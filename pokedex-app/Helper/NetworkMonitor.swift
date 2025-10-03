//
//  NetworkMonitor.swift
//  pokedex-app
//
//  Created by PhinCon on 16/09/25.
//

import Foundation
import Network

protocol NetworkChecking {
    var isConnected: Bool { get }
}

class NetworkMonitor: NetworkChecking {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    //everyone can read
    //only this type can write
    private(set)var isConnected: Bool = true
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.isConnected = (path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
    
}
