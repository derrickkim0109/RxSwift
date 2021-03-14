//
//  SessionManagerProtocol.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/8/21.
//

import Alamofire
import Foundation
import UIKit

protocol SessionManagerProtocol {
    
    typealias RequestModifier = (inout URLRequest) throws -> Void

    @discardableResult
    func request(
    _ convertible: URLConvertible,
    method: HTTPMethod,
    parameters: Parameters?,
    encoding: ParameterEncoding,
    headers: HTTPHeaders?,
    interceptor: RequestInterceptor?,
    requestModifier: RequestModifier?
    ) -> DataRequest
    
}

extension Session: SessionManagerProtocol {

}

