//
//  AppDelegate.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/28.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if UserDefaults.standard.value(forKey: "accessToken") != nil {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "ProductsNaviTableViewController")
            
            self.window?.rootViewController = mainViewController
            
        } else {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            
            self.window?.rootViewController = loginViewController
        }
        
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        // just making sure we send the notification when the URL is opened in SFSafariViewController
        if (sourceApplication == "com.apple.SafariViewService") {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kCloseSafariViewControllerNotification), object: url)
            return true
        }
        
        return true
    }
    
    class var shared: AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
        
    }

}

