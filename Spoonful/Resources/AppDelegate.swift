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
    let config = STPPaymentConfiguration.shared()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        STPPaymentConfiguration.shared().publishableKey = "pk_test_MKeRf4JsaxmdN5LSbSmIBff2"
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        navigationController.navigationBar.barTintColor = darktwo
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController.navigationBar.shadowImage = UIImage()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        setupStripe()
        
        return true
    }
    
    private func setupStripe() {
        
        config.publishableKey = stripePublishableKey
//        config.appleMerchantIdentifier = appleMerchantID
        config.companyName = companyName
        config.requiredBillingAddressFields = .full
//        config.additionalPaymentMethods = .applePay
        
        // Create card sources instead of card tokens
        config.createCardSources = true;
    }
}

