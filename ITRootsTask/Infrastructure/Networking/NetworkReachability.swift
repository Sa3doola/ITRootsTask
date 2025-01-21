//
//  NetworkReachability.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Foundation
import Alamofire

protocol NetworkReachabilityDelegate: AnyObject {
    func listenOnNetwork()
    var isConnected: Bool { get }
    var isConnectedPublisher: Published<Bool>.Publisher { get }
}

class NetworkReachability: NetworkReachabilityDelegate, ObservableObject {
        
    private let reachability = Reachability()
    @Published var isConnected: Bool = false

    var isConnectedPublisher: Published<Bool>.Publisher {
        $isConnected
    }

    func listenOnNetwork() {
        reachability.listen { [weak self] status in
            guard let self = self else { return }
            self.isConnected = self.handleNetworkStatus(status)
        }
    }
    
    private func handleNetworkStatus(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) -> Bool {
        switch status {
        case .notReachable:
            print("No internet connection")
            return false
        case .reachable(.ethernetOrWiFi):
            print("Connected via WiFi")
            return true
        case .reachable(.cellular):
            print("Connected via Cellular")
            return true
        case .unknown:
            print("Unknown network status")
            return false
        }
    }
    
    deinit {
        print("\(Self.self) is deinit, No memory leak found")
    }
    
}
