//
//  AppDelegate.swift
//  YYSVod
//
//  Created by minusapple on 2025/12/15.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AHFullscreenRotation.orientation
    }
    
}
