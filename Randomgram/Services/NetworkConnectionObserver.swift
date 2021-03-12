//
//  NetworkConnectionObserver.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 11.03.2021.
//

import Foundation
import Network

protocol NetworkObserverSubscriber: class {
    
    func showLostNetworkAlert()
    func showConnectionRecoveredAlert()
    
}

final class NetworkObserver {
    
    private let monitor: NWPathMonitor
    private lazy var subscribers = [NetworkObserverSubscriber]()
    private var firstNotification = true
    
    init() {
        
        self.monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            
            if path.status == .unsatisfied {
                self.notifyOfLostConnection(subscribers: self.subscribers)
            }
            
            if path.status == .satisfied {
                if self.firstNotification {
                    self.firstNotification.toggle()
                    return
                }
                self.notifyOfConnectionRecovery(subscribers: self.subscribers)
            }
        }
        
    }
    
    deinit {
        self.detachSubscribers()
    }
    
    func attachSubscribers(subscribers: [NetworkObserverSubscriber]) {
        self.subscribers.append(contentsOf: subscribers)
        startMonitoring()
    }
    
    private func startMonitoring() {
        let queue = DispatchQueue(label: "Network changes", qos: .background)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: (DispatchTime.now() + 5)) {
            self.monitor.start(queue: queue)
        }
    }
    
    private func detachSubscribers() {
        self.subscribers.removeAll()
    }
    
    private func notifyOfLostConnection(subscribers: [NetworkObserverSubscriber]?) {
        
        if let subscribers = subscribers {
            subscribers.forEach { $0.showLostNetworkAlert()}
        }
    }
    
    private func notifyOfConnectionRecovery(subscribers: [NetworkObserverSubscriber]?) {
        
        if let subscribers = subscribers {
            subscribers.forEach { $0.showConnectionRecoveredAlert()}
        }
    }
    
}


