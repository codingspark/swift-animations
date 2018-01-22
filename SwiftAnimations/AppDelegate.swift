//
//  AppDelegate.swift
//  SwiftAnimations
//
//  Created by Samuele Perricone on 18/01/2018.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let appearance = UINavigationBar.appearance()
        
        appearance.tintColor = UIColor.darkGray
        
        appearance.barTintColor = UIColor.darkGray
        

        let titleAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor: UIColor.orange]
        
        let disabledTitleAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor: UIColor.orange.withAlphaComponent(0.2)]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(titleAttributes, for: .normal)
        
        UIBarButtonItem.appearance().setTitleTextAttributes(disabledTitleAttributes, for: .disabled)
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillTerminate(_ application: UIApplication) {}
}

