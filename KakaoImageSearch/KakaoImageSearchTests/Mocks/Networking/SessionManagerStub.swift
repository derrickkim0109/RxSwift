//
//  SessionManagerStub.swift
//  KakaoImageSearchTests
//
//  Created by jc.kim on 3/8/21.
//


@testable import Alamofire
@testable import KakaoImageSearch


final class SessionManagerStub: SessionManagerProtocol {
    
    var requestParameters: (
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?
    )?
    
    func request(_ convertible: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, interceptor: RequestInterceptor?, requestModifier: RequestModifier?) -> DataRequest {
        self.requestParameters = (
            url: convertible,
            method: method,
            parameters: parameters
        )
        
        return AF.request("")
    }
    
}
