//
//  AppDelegate.swift
//  CamListTask
//
//  Created by mohamed salah on 10/21/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        setRootViewController()
        return true
    }
    
    func setRootViewController() {
        self.window?.rootViewController = UINavigationController(rootViewController: NearByPlacesViewController())
    }
}

