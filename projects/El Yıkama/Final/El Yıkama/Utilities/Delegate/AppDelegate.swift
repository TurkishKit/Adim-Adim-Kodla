//
//  AppDelegate.swift
//  El Yıkama
//
//  Created by Can Balkaya on 5/20/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Functions
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appereance = UINavigationBarAppearance()
        appereance.configureWithOpaqueBackground()
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.bold)
        ]
        
        appereance.largeTitleTextAttributes = attrs
        UINavigationBar.appearance().scrollEdgeAppearance = appereance
        
        UIApplication.shared.unregisterForRemoteNotifications()
        
        return true
    }
}
