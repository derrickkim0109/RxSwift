//
//  ImageServiceProtocol.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/8/21.
//

import Alamofire

protocol ImageServiceProtocol {
    @discardableResult
    func search(query: String, page: Int, completionHandler: @escaping (AFResult<ImageSearchResult?>) -> Void) -> DataRequest
}
