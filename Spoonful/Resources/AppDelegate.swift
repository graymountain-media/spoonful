//
//  AppDelegate.swift
//  Spoonful
//
//  Created by Jake Gray on 9/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase
import BraintreeDropIn

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        navigationController.navigationBar.barTintColor = darktwo
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController.navigationBar.shadowImage = UIImage()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        configureBraintreeUI()
        
        return true
    }
    
    private func configureBraintreeUI() {        BTUIKAppearance.sharedInstance()?.tintColor = main
        BTUIKAppearance.sharedInstance()?.formBackgroundColor = .white
        BTUIKAppearance.sharedInstance()?.primaryTextColor = .black
        BTUIKAppearance.sharedInstance()?.secondaryTextColor = .black
        BTUIKAppearance.sharedInstance()?.blurStyle = UIBlurEffect.Style.light
        BTUIKAppearance.sharedInstance()?.useBlurs = false
    }
}

