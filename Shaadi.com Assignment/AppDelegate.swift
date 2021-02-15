//
//  AppDelegate.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let listVC = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = false
        navigationController.viewControllers = [listVC]

        // Setting up the root view-controller with navigationn controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
}

