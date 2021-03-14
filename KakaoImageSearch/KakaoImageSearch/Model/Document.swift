//
//  Document.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/8/21.
//

import Foundation

// MARK: - Document
struct Document: Decodable {
    let datetime, displaySitename: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case datetime
        case displaySitename = "display_sitename"
        case imageURL = "image_url"
    }
}
