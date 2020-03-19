//
//  OfflineViewController.swift
//  MVVM
//
//  Created by Milan Panchal on 19/03/20.
//  Copyright © 2020 Jeenal Infotech. All rights reserved.
//

import UIKit

class OfflineViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.sharedInstance.reachability.whenReachable = { reachability in
            self.dismissOfflinePage()
        }
    }
    
}
