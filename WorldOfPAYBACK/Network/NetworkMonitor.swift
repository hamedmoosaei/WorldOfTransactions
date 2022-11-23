//
//  NetworkMonitor.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import Network
import RxCocoa

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    public var connectionStatus: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    private let monitor: NWPathMonitor

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status != .unsatisfied
            self?.connectionStatus.accept(isConnected)
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
