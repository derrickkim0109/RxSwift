//
//  ViewController.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/4/21.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SearchImageViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = ImageItemsViewModel()
    
    var disposeBag = DisposeBag()
    
    var imageService : ImageService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }

    
    private func configureUI() {
        searchBar.autocapitalizationType = .none
        
        listCollectionView.dataSource = nil
        listCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        listCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    
    private func setupBindings() {
        let itemsCount = viewModel.searchImageItems.map{$0.count-1}
        let prefetchItems = listCollectionView.rx.prefetchItems
            .map{$0.last?.row ?? 0}
        
        Observable.combineLatest(itemsCount, prefetchItems)
            .asDriver(onErrorJustReturn: (0,0))
            .filter{ $0.0 > 0 }
            .filter{ $0 == $1 }
            .map{_ in
                self.viewModel.page += 1
                return (self.searchBar.text ?? "", self.viewModel.page)}
            .drive(viewModel.searchBarObservable)
            .disposed(by: disposeBag)
        
        
        viewModel.searchImageItems
            .do(onNext: {
                if $0.isEmpty { self.listCollectionView.emptyMessage() }
                else { self.listCollectionView.restore() }
            })
            .bind(to: listCollectionView.rx.items(cellIdentifier: ImageCollectionViewCell.identifier,
                                                  cellType: ImageCollectionViewCell.self))
            { index, item, cell in
                cell.setData(item)
            }
            .disposed(by: disposeBag)
        
        
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
            .do(onNext: {_ in self.viewModel.totalItems = []})
            .map{($0, 1)}
            .asDriver(onErrorJustReturn: ("",1))
            .drive(viewModel.searchBarObservable)
            .disposed(by: disposeBag)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "DetailViewController",
           let detailVC = segue.destination as? DetailViewController {
            
            if let tuple = sender as? (UIImage?, IndexPath) {
                let items = viewModel.searchImageItems.value
                detailVC.detailImageItems.accept((tuple.0, items[tuple.1.row]))
            }
        }
    }
    
    
}


extension SearchImageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
        performSegue(withIdentifier: "DetailViewController", sender: (cell?.searchImageView.image , indexPath))
    }
    
}


extension SearchImageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        var bounds = collectionView.bounds
        bounds.size.height += bounds.origin.y
        
        var width = bounds.width - (layout.sectionInset.left + layout.sectionInset.right)
        var height = bounds.height - (layout.sectionInset.top + layout.sectionInset.bottom)
        
        width = (width - (layout.minimumInteritemSpacing * 2 )) / 3
        height = width
        
        return CGSize(width: width.rounded(.down), height: height.rounded(.down))
    }
    
}

