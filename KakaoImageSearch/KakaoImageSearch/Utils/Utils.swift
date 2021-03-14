//
//  Utils.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/6/21.
//

import UIKit

extension String {
    func currencyKR() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd\'T\'HH:mm:ss\'.000\'z"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "Ko_kr")
        
        return "\(dateFormatter.string(from: date!))"
    }
}


extension UICollectionView {
    func emptyMessage() {
        let label = UILabel(frame: self.bounds)
        label.text = "검색 결과가 없습니다."
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        self.backgroundView = label
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
