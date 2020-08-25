//
//  AppDelegate.swift
//  Farelki
//
//  Created by роман поздняков on 06/04/2019.
//  Copyright © 2019 romchick. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var startVC :UIViewController
        
//        if PersistanceService.firstEntry {
            startVC = MenuViewController()
//        } else {
//            startVC = RegisterViewController()
//        }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startVC
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

