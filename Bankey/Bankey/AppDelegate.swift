//
//  AppDelegate.swift
//  Bankey
//
//  Created by simonecaria on 29/01/25.
//

import UIKit

let appColor : UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

  
    var window : UIWindow?
    
    let loginViewController =  LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        registerForNotification()
        displayLogin()
        
        

        
        return true
    }
    
    func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
    func displayLogin(){
        setRootViewController(loginViewController)
    }
    
    func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }

    private func prepMainView() {
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
    
    

}

extension AppDelegate :  LoginViewControllerDelegate {
    func didLogin() {
        displayNextScreen()
    }
}

extension AppDelegate : OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
    
}

extension AppDelegate : DummyViewControllerDelegate {
    @objc func didLogout() {
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
