//
//  BaseViewController.swift
//  MVVM
//
//  Created by Milan Panchal on 19/03/20.
//  Copyright © 2020 Jeenal Infotech. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    func showOfflinePage() -> Void {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "OfflineViewController") as? OfflineViewController else { return  }
        self.presentOnRoot(with: vc, embedNavController: false)
    }
    
    func dismissOfflinePage() -> Void {

        self.dismiss(animated: true) {
            print("Offline View Controller removed")
        }
    }
    
}

extension UIViewController {
    func presentOnRoot(with viewController : UIViewController, embedNavController: Bool) {
        
        var presentVC = viewController
        
        if embedNavController {
            presentVC = UINavigationController(rootViewController: viewController)
        }
        
        presentVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(presentVC, animated: false, completion: nil)

    }
    
}
