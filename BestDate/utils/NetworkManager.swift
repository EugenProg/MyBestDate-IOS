//
//  NetworkManager.swift
//  BestDate
//
//  Created by Евгений on 15.05.2023.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    static var shared = NetworkManager()

    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    @Published private(set) var isConnected = true
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
