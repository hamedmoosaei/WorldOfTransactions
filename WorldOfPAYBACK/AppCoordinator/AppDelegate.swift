//
//  AppDelegate.swift
//  WorldOfPAYBACK
//
//  Created by Hamed on 11/13/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        return true
    }
}

