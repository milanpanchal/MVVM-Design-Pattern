//
//  NetworkManager.swift
//  MVVM
//
//  Created by Milan Panchal on 19/03/20.
//  Copyright © 2020 Jeenal Infotech. All rights reserved.
//

import UIKit
import Reachability

final class NetworkManager: NSObject {

    var reachability: Reachability!

    // Create a singleton instance
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()


    var users: [User] = []
    private let baseUrl = "https://randomuser.me/api/"

    //Private initializer
    private override init() {
        // Set up API instance
        super.init()

        do {
            reachability = try Reachability()
        } catch let error {
            print("Error: \(error)")
        }
        
        // Register an observer for the network status
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

    }
    
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }

    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }

    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }

    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }

    
}

extension NetworkManager {

    func fetchUsers(withLimit limit: Int = 1, completionHandler: @escaping ([User]) -> Void) {
      let url = URL(string: baseUrl + "?results=\(limit)")!
        print("fetching data for url: \(url)")
      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching users: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
          return
        }

        if let data = data, let userList = try? JSONDecoder().decode(UserList.self, from: data) {
            completionHandler(userList.results)
        }
      })
      task.resume()
    }

}
