//
//  AppDelegate.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/20/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit
import UserNotifications
import HealthKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var healthStore: HKHealthStore?
    //let tintColor = UIColor(red:0.76, green:0.27, blue:0.00, alpha:1.0) // Oregon State Orange
    let tintColor = UIColor(traditionalRed: 0x4E, green: 0x73, blue: 0x00, alpha: 1.0) // Oregon State Green

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // Set tint to Oregon State University Orange
        window?.tintColor = tintColor
        
        // Set up HealthKit Health Store
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
        
        //FIXME: clear notifications on iOS 9
//        application.cancelAllLocalNotifications()
        
        // Setup Daily Notifications
        if application.scheduledLocalNotifications?.count == 0 || !UserDefaults.standard.bool(forKey: "DailyNotifications") {
            
            // setup notification
            if #available(iOS 10.0, *) {
                print("iOS10+")
                // For iOS10 and above
                
                // get calendar unit for 5pm everyday
                let now = Date()
                let calendar = Calendar(identifier: .gregorian)
                let todayAtFive = calendar.date(bySettingHour: 17, minute: 0, second: 0, of: now)
                let unitFlags: Set<Calendar.Component> = [.second, .minute, .hour, .day, .month, .year]
                let todayAtFiveComponents = Calendar.current.dateComponents(unitFlags, from: todayAtFive!)
                
                // request authorization
                let center = UNUserNotificationCenter.current()
                center.delegate = nil
                center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
                    if !granted {
                        print("Unresolved UNNotificationCenter Request Error: \(String(describing: error))")
                    }
                })
                
                // define content of notification
                let content = UNMutableNotificationContent()
                content.body = dailyNotificationBody
                content.sound = UNNotificationSound.default()
                
                // deliver notification at 5pm daily
                let trigger = UNCalendarNotificationTrigger(dateMatching: todayAtFiveComponents, repeats: true)
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
                
                // request notification
                center.add(request, withCompletionHandler: { (error) in
                    if (error != nil) {
                        print("Unresolved UNNotificationCenter add request error: \(String(describing: error))")
                    }
                })
            } else {
                print("iOS9")
                // Fallback on earlier versions
                
                // get calendar unit for 5pm everyday
                let now = NSDate()
                let calendar = NSCalendar(identifier: .gregorian)
                let todayAtFive = calendar?.date(bySettingHour: 17, minute: 0, second: 0, of: now as Date, options: NSCalendar.Options())
                
                
                // request authorization
                application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
                
                // define content of notification
                let notification = UILocalNotification()
                notification.alertBody = dailyNotificationBody
                notification.soundName = UILocalNotificationDefaultSoundName
                
                // deliver notification at 5pm daily
                notification.fireDate = todayAtFive
                notification.repeatInterval = .day
//                notification.fireDate = calendar?.date(byAdding: .second, value: 5, to: now as Date, options: NSCalendar.Options())
                
                // request notification
                application.scheduleLocalNotification(notification)
            }
            
            UserDefaults.standard.setValue(true, forKey: "DailyNotifications")
            UserDefaults.standard.synchronize()
            
            print("Notification Scheduled")
        }
        
        // If this is first launch, create necessary files
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
            
            fileAccessQueue.async(execute: {
                let requiredFiles = [logDataFile, locationDataFile]
                for file in requiredFiles {
                    do {
                        let path = mainDir.appendingPathComponent(file)
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
        
        // Check if registered, if not show registration
        if !UserDefaults.standard.bool(forKey: "hasRegistered") {
            let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
            // Set tint to Oregon State University Orange
            window?.tintColor = tintColor
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        let alert = UIAlertController(title: notification.alertTitle, message: notification.alertBody, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
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
            print("Deferring updates (from App Delegate)")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Setup Location
        if (UserDefaults.standard.object(forKey: "userID") != nil) {
            print("Checking location delegate")
            location.delegate = window?.rootViewController
            if location.checkLocationAuth() {
                location.startMonitoringLocation()
                location.getLatestLocation()
            }
        } else {
            print("Trying to check location, not logged in")
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
