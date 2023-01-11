//
//  AppDelegate.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 11/13/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        NetworkMonitor.shared.startMonitoring()
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        NetworkMonitor.shared.stopMonitoring()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        NetworkMonitor.shared.startMonitoring()
    }
}

