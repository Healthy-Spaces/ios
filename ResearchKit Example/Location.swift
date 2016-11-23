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
    
    // MARK: - Configurable Variables
    let distanceFilter: Double = 25 //meters
    let deferredDistance: Double = 25 //meters
    let deferredTimeout: Double = 5 //seconds
    
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
            print("Auth Status: \(locationAuth)")
            break
        }
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
        
        if locationAuth == .authorizedAlways && CLLocationManager.locationServicesEnabled() {
            return true
        } else {
            return false
        }
    }
    
    func startMonitoringLocation() {
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = distanceFilter
        locationManager?.startUpdatingLocation()
    }
    
    func moveToDeferredUpdates() -> Bool {
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            print("deferring location updates")
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.distanceFilter = kCLDistanceFilterNone
            locationManager?.allowDeferredLocationUpdates(untilTraveled: deferredDistance, timeout: deferredTimeout)
            return true
        } else {
            return false
        }
    }
    
    func getLatestLocation() {
        //print(locationManager?.location?.timestamp.timeIntervalSinceNow)
        if locationManager?.location == nil {
            print("no location data")
        } else if (locationManager?.location?.timestamp.timeIntervalSinceNow)! < Double(-1800) {
            locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager?.distanceFilter = 10
            locationManager?.requestLocation()
            print("Requesting new location: \(locationManager?.location)")
        } else {
            print("Using old location: \(locationManager?.location)")
        }
    }
    
    func getLocationString(location: CLLocation) -> String {
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let time = location.timestamp
        let horizontalAccuracy = location.horizontalAccuracy
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd h:mm:ss"
        
        var locationsString = ""
        
        locationsString += String(lat)
        locationsString += ", "
        locationsString += String(lon)
        locationsString += " (+/- "
        locationsString += String(horizontalAccuracy)
        locationsString += "m) @ "
        locationsString += formatter.string(from: time)
        locationsString += "\n"
        
        return locationsString
    }
    
    // MARK: - CLLocationManager Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Locations: \(locations)")
        
        let locationsString = self.getLocationString(location: locations.first!)
        
        fileAccessQueue.async() {
            do {
                let path = mainDir.appendingPathComponent(locationDataFile)
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
            
            DispatchQueue.main.async {
                self.delegate.reloadLocationData()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("Auth Changed to notDetermined")
            break
        case .restricted:
            print("Auth Changed to restricted")
            break
        case .denied:
            print("Auth Changed to denied")
            break
        case .authorizedAlways:
            print("Auth Changed to authorizedAlways")
            break
        case .authorizedWhenInUse:
            print("Auth Changed to authorizedWhenInUse")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        // CLError.deferredFailed
        let clError = error as! CLError
        if clError.code.rawValue == 11 {
            print("Defer error, trying to defer again")
            _ = self.moveToDeferredUpdates()
        } else {
            print("Unresolved Location Deferred Error: \(error)")
        }
    }
}

protocol LocationDelegate {
    func presentLocationRestrictedAlert()
    func presentChangedAuthAlert()
    func reloadLocationData()
}
