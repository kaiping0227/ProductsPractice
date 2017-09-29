//
//  MainViewController.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/28.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit
import SafariServices

let kCloseSafariViewControllerNotification = "kCloseSafariViewControllerNotification"

class MainViewController: UIViewController, SFSafariViewControllerDelegate {

    var safariViewController: SFSafariViewController?
    
    let fetchManager = FetchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.safariLogin(notification:)), name: Notification.Name(rawValue: kCloseSafariViewControllerNotification), object: nil)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let authURL = URL(string: "http://igoodtravel.com/oauth/authorize?client_id=" + OAuth.clientID.rawValue + "&redirect_uri=" + OAuth.redirectUri.rawValue + "&response_type=code")
        
        safariViewController = SFSafariViewController(url: authURL!)
        
        safariViewController!.delegate = self
        
        self.present(safariViewController!, animated: true, completion: nil)
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    
    }
    
    @objc func safariLogin(notification: Notification) {
        
        let url = notification.object as! URL
        
        guard let requestCode = url.valueOf(queryParamaterName: "code") else { return }
        
        print(requestCode)
        
        fetchManager.fetchToken(requestCode)
        
        self.safariViewController!.dismiss(animated: true, completion: nil)
        
    }
    
}
