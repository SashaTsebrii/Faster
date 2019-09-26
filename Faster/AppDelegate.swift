//
//  AppDelegate.swift
//  Faster
//
//  Created by Aleksandr Tsebrii on 9/5/19.
//  Copyright © 2019 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = WelcomViewController()
        
        // To change background colour.
        UINavigationBar.appearance().barTintColor = UIColor.white
        // To change colour of tappable items.
        UINavigationBar.appearance().tintColor = UIColor.blue
        // To apply textAttributes to title i.e. colour, font etc.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.blue,
                                                            .font : UIFont.init(name: Constant.Font.Name.regular,
                                                                                size: Constant.Font.Size.regular)!]
        // To control navigation bar's translucency.
        UINavigationBar.appearance().isTranslucent = false
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
}

