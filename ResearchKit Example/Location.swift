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
        
        let lat = locations.first?.coordinate.latitude
        let lon = locations.first?.coordinate.longitude
        let time = locations.first?.timestamp
        let locationsString = self.getLocationString(lat: lat!, lon: lon!, time: time!)
        
        fileAccessQueue.async() {
            do {
                let path = try mainDir.appendingPathComponent(locationDataFile)
                let fileHandle = try FileHandle(forWritingTo: path)
                fileHandle.seekToEndOfFile()
                let data = locationsString.data(using: String.Encoding.utf8)
                fileHandle.write(data!)
            } catch let error as NSError {
                switch error.code {
                case 2:
                    print("Writing to new file")
                    write(string: locationsString, toNew: locationDataFile)
                default:
                    print("Unresolved Location Data Write Error: \(error), \(error.userInfo)")
                }
            }
        }
        
        delegate.reloadLocationData()
    }
    
    func getLocationString(lat: CLLocationDegrees, lon: CLLocationDegrees, time: NSDate) -> String {
        
        var locationsString = ""
        
        locationsString += String(lat)
        locationsString += ", "
        locationsString += String(lon)
        locationsString += " @ "
        locationsString += String(time)
        locationsString += "\n"
        
        return locationsString
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Auth Changed")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Error: \(error), \(error.userInfo)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        // CLError.deferredFailed
        if error?.code == 11 {
            print("Defer error, trying to defer again")
            _ = self.moveToDeferredUpdates()
        } else {
            print("Unresolved Location Deferred Error: \(error), \(error?.userInfo)")
        }
    }
}

protocol LocationDelegate {
    func presentLocationRestrictedAlert()
    func presentChangedAuthAlert()
    func reloadLocationData()
}
