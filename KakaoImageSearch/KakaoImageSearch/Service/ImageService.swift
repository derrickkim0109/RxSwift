//
//  APIService.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/5/21.
//

import Foundation
import RxSwift
import Alamofire

let SEARCH_IMAGE_URL = "https://dapi.kakao.com/v2/search/image"
let API_KEY = "KakaoAK babff94d55071a0898f77b445ffd368d"


final class ImageService: ImageServiceProtocol {
    
    private let sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManagerProtocol) {
        self.sessionManager = sessionManager
    }
    
    func searchRx(_ query: String,_ page: Int = 1) -> Observable<[Document]> {
        return Observable.create { emitter in
            _ = self.search(query: query, page: page) { (result) in
                switch result {
                case .success(let imageSearchResult):
                    if let imgs = imageSearchResult {
                        emitter.onNext(imgs.documents)
                        emitter.onCompleted()
                    }
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    
    func search(query: String = "", page: Int = 1, completionHandler: @escaping (AFResult<ImageSearchResult?>) -> Void) -> DataRequest {
        let parameters: Parameters = [
            "query":query,
            "page":"\(page)",
            "size":"30",
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": API_KEY,
            "Content-Type": "application/json"
        ]
        
        
        return self.sessionManager.request(SEARCH_IMAGE_URL, method: .get, parameters: parameters, encoding: URLEncoding(), headers: headers, interceptor: nil, requestModifier: nil)
            .responseData { response in
                
                let result = response.result.map { (data) in
                     try? JSONDecoder().decode(ImageSearchResult.self, from: data)
                }
                
                completionHandler(result)
            }
                
    }
    
}

