//
//  ImageServiceTests.swift
//  KakaoImageSearchTests
//
//  Created by jc.kim on 3/8/21.
//

import XCTest
import Alamofire
@testable import KakaoImageSearch

final class ImageServiceTests: XCTestCase {
    func testSearch_callsSearchAPIwithParameters(){
        // given
        let sessionMagager = SessionManagerStub()
        let service = ImageService(sessionManager: sessionMagager)
        
        // when
        _ = service.search(query: "Swift", page: 1, completionHandler: { _ in})
        
        // then
        let params = sessionMagager.requestParameters

        XCTAssertEqual(
            try params?.url.asURL().absoluteString,
            SEARCH_IMAGE_URL
        )
        
        let expectedURL = SEARCH_IMAGE_URL
        let actualURL = try? sessionMagager.requestParameters?.url.asURL().absoluteString
        XCTAssertEqual(actualURL, expectedURL)

        
        let expectedMethod = HTTPMethod.get
        let actualMethod = sessionMagager.requestParameters?.method
        XCTAssertEqual(expectedMethod, actualMethod)

        
        let expectedParameters = [
            "query":"Swift",
            "page": "1",
            "size":"30"
        ]
        let actualParameters = sessionMagager.requestParameters?.parameters as? [String:String]
        XCTAssertEqual(expectedParameters, actualParameters)
    }
}
