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
        let netService = NetworkService(endPoint: TransactionEndPoint.transactionList)
        let localDS = TransactionJsonReaderDataSource()
        let remoteDS = TransactionURLSessionDataSource(networkService: netService)
        let repo = TransactionListRepositoryImpl(remoteDataSource: remoteDS, localDataSource: localDS)
        let vm = TransactionListViewModel(transactionRepository: repo)
        let vc = TransactionListViewController(viewModel: vm)
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
