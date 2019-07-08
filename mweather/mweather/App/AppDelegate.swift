//
//  AppDelegate.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let defaults = [
        "Ulyanovsk",
        "New York",
        "Los Angeles"
    ]
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Router.shared.start()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

protocol AppRouter {
    func start()
}

extension Router: AppRouter {
    func start() {
        app()?.window = UIWindow(frame: UIScreen.main.bounds)
        app()?.window?.rootViewController = ForecastViewController(dependencies: Dependencies.shared)
        app()?.window?.makeKeyAndVisible()
    }
}


