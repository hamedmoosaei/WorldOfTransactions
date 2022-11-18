//
//  AppCoordinator.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/18/22.
//

import UIKit

class AppCoordinator {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = UITabBarController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
