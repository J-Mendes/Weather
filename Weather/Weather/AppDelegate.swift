//
//  AppDelegate.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.setupAppearance()
        
        // inject dependencies on first view controller
        if let navigationController: UINavigationController = window?.rootViewController as? UINavigationController,
            let firstViewController: WeatherTableViewController = navigationController.viewControllers.first as? WeatherTableViewController {
            firstViewController.dataService = DataService()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Present full screen view to cover app contents when it moves into the background
        
        let viewController: UIViewController = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "launchScreen")
        self.window?.rootViewController?.present(viewController, animated: false, completion: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Dismiss full screen cover content view
        
        self.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.setupAppearance()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // MARK: - Appearance overrides
    
    fileprivate func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.neutralBlueColor()
        
        UIRefreshControl.appearance().tintColor = UIColor.white
        UIProgressView.appearance(whenContainedInInstancesOf: [UIRefreshControl.self]).tintColor = UIColor.white
        
        UITableViewCell.appearance().tintColor = UIColor.white
    }

}
