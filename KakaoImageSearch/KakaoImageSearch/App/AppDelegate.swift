//
//  AppDelegate.swift
//  KakaoImageSearch
//
//  Created by jc.kim on 3/4/21.
//

import UIKit
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let rootViewController = self.rootViewController() {
            let imageService = ImageService(sessionManager: Session.default)
            rootViewController.imageService = imageService
        }
        
        return true
    }

    private func rootViewController() -> SearchImageViewController? {
        guard let nav = self.window?.rootViewController as? UINavigationController else { return nil }
        return nav.viewControllers.first as? SearchImageViewController
    }

}

