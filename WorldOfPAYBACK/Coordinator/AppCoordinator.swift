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
        let vm = TransactionListViewModel()
        let vc = TransactionListViewController(viewModel: vm)
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
