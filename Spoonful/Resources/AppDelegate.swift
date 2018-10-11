//
//  AppDelegate.swift
//  Spoonful
//
//  Created by Jake Gray on 9/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        STPPaymentConfiguration.shared().publishableKey = "pk_test_MKeRf4JsaxmdN5LSbSmIBff2"
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        navigationController.navigationBar.barTintColor = main
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

