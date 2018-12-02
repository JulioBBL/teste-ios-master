//
//  AppDelegate.swift
//  Teste-iOS-BTG
//
//  Created by BTG Pactual digital on 30/11/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        APIWorker().getFunds { (funds) in
            print("amount:",funds.count,"\nfirst:",funds.first)
        }
        
        // Override point for customization after application launch.
        return true
    }
}

