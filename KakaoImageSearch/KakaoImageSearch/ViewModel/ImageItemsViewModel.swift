//
//  ViewModel.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/6/21.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ImageItemsViewModel {
    
    lazy var searchBarObservable : BehaviorRelay<(String, Int)> = BehaviorRelay(value: ("", page))
    let searchImageItems: BehaviorRelay<[Document]> = BehaviorRelay(value: [])
    
    var totalItems = [Document]()
    var page = 1

    var disposeBag = DisposeBag()
    
    let imageService = ImageService(sessionManager: Session.default)
    

    init() {
        searchBarObservable
            .flatMap(imageService.searchRx)
            .map(appendItems)
            .asDriver(onErrorJustReturn: [])
            .drive(searchImageItems)
            .disposed(by: disposeBag)
    }
        
    private func appendItems(_ items: [Document]) -> [Document]{
        self.totalItems.append(contentsOf: items)
        return totalItems
    }
}

