//
//  DetailViewController.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/5/21.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var displaySiteNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    
    @IBAction func popAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let detailImageItems: BehaviorRelay<(UIImage?, Document?)> = BehaviorRelay(value: (nil, nil))
    
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    
    private func configureUI() {
        scrollView.bounces = false
        
        dismissButton.tintColor = .darkGray
        dismissButton.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle:.largeTitle)), for: .normal)
    }
    
    
    private func setupBindings() {
        detailImageItems
            .map{$0.0}
            .filter{$0 != nil}
            .map{$0!}
            .bind(to: detailImageView.rx.image)
            .disposed(by: disposeBag)
        
        
        detailImageItems
            .map{$0.1}
            .do(onNext: { [weak self] doc in self?.displaySiteNameLabel.isHidden = doc == nil })
            .filter{$0?.displaySitename != nil}
            .map{$0!.displaySitename}
            .bind(to: displaySiteNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        detailImageItems
            .map{$0.1}
            .do(onNext: { [weak self] doc in self?.dateTimeLabel.isHidden = doc == nil })
            .filter{$0?.datetime != nil}
            .map{$0!.datetime.currencyKR()}
            .bind(to: dateTimeLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
