//
//  AppDelegate.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/20/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Setup Notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        
        // Set tint to Oregon State University Orange
        window?.tintColor = UIColor(red:0.76, green:0.27, blue:0.00, alpha:1.0)
        
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
            
            fileAccessQueue.async(execute: { 
                let requiredFiles = [logDataFile, locationDataFile]
                for file in requiredFiles {
                    do {
                        let path = try mainDir.appendingPathComponent(file)
                        let emptyString = ""
                        try emptyString.write(to: path, atomically: true, encoding: String.Encoding.utf8)
                    } catch let error as NSError {
                        print("Unresolved First Launch Error: \(error), \(error.userInfo)")
                    }
                }
            })
            
            UserDefaults.standard.setValue(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        let alert = UIAlertController(title: notification.alertTitle, message: notification.alertBody, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: notification.alertAction, style: .default, handler: nil)
        alert.addAction(okayAction)
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if location.moveToDeferredUpdates() {
            print("Deferring updates")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Setup Location
        location.delegate = window?.rootViewController
        if location.checkLocationAuth() {
            location.startMonitoringLocation()
            location.getLatestLocation()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
