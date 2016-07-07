//
//  Location.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/5/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class Location: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager? = nil
    var delegate: LocationDelegate!
    
    // MARK: - Location Helper Methods
    
    func checkLocationAuth() -> Bool {
        let locationAuth = CLLocationManager.authorizationStatus()
        switch locationAuth {
        case .denied, .restricted:
//            delegate.presentLocationRestrictedAlert()
            return false
        case .notDetermined:
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
            break
        default:
            break
        }
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
        
        if CLLocationManager.locationServicesEnabled() {
            return true
        } else {
            return false
        }
    }
    
    func startMonitoringLocation() {
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.distanceFilter = 10
        locationManager?.startUpdatingLocation()
    }
    
    func moveToDeferredUpdates() -> Bool {
        
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.distanceFilter = kCLDistanceFilterNone
            locationManager?.allowDeferredLocationUpdates(untilTraveled: 100, timeout: 300)
            return true
        } else {
            return false
        }
    }
    
    func getLatestLocation() {
        print(locationManager?.location?.timestamp.timeIntervalSinceNow)
        if locationManager?.location?.timestamp.timeIntervalSinceNow < -1800 {
            locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager?.distanceFilter = 10
            locationManager?.requestLocation()
        } else {
            print(locationManager?.location)
        }
    }
    
    // MARK: - CLLocationManager Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Locations: \(locations)")
        
        fileAccessQueue.async() {
            do {
                let locationsString = String(locations)
                let path = try mainDir.appendingPathComponent(locationDataFile)
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: String(path)) {
                    try locationsString.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                } else {
                    let fileHandle = try FileHandle(forWritingTo: path)
                    fileHandle.seekToEndOfFile()
                    let data = locationsString.data(using: String.Encoding.utf8)
                    fileHandle.write(data!)
                }
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        delegate.reloadLocationData()
        
//        let notification = UILocalNotification()
//        notification.alertTitle = "Updated Location"
//        notification.alertBody = "\(locations)"
//        notification.alertAction = "Yay!"
//        notification.soundName = UILocalNotificationDefaultSoundName
//        UIApplication.shared().presentLocalNotificationNow(notification)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Auth Changed")
        let locationAuth = CLLocationManager.authorizationStatus()
        switch locationAuth {
        case .denied, .restricted:
//            delegate.presentLocationRestrictedAlert()
            return
        case .notDetermined:
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Error: \(error), \(error.userInfo)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print("Location Deferred Error: \(error!), \((error?.userInfo)!)")
        
        if error?.code == 11 {
            print("trying to defer again")
            _ = self.moveToDeferredUpdates()
        }
    }
}

protocol LocationDelegate {
    func presentLocationRestrictedAlert()
    func presentChangedAuthAlert()
    func reloadLocationData()
}
