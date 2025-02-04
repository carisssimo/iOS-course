//
//  AppDelegate.swift
//  Bankey
//
//  Created by simonecaria on 29/01/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window : UIWindow?
    var loginViewController =  LoginViewController()
    var onboardingContainerViewController = OnboardingContainerViewController()
    var dummyViewController = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        window?.rootViewController = loginViewController
        onboardingContainerViewController.delegate = self
        dummyViewController.delegate = self

        
        return true
    }

 


}

extension AppDelegate :  LoginViewControllerDelegate {
    func didLogin() {
        
        if LocalState.hasOnBoarded {
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate : OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnBoarded = true
        setRootViewController(dummyViewController)
    }
    
}

extension AppDelegate : DummyViewControllerDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc : UIViewController, animated: Bool = true){
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil , completion: nil)
    }
}
