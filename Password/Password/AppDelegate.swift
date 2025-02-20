//
//  AppDelegate.swift
//  Password
//
//  Created by simonecaria on 20/02/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        
        return true
    }

}

