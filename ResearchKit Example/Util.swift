//
//  Util.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/8/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation

public func write(string: String, toNew file: String) {
    do {
        let path = mainDir.appendingPathComponent(file)
        try string.write(to: path, atomically: true, encoding: String.Encoding.utf8)
    } catch let error as NSError {
        print("new string file writing error: \(error), \(error.userInfo)")
    }
}

public func imageWithColor(_ color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext((rect.size))
    let context = UIGraphicsGetCurrentContext()
    
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

extension UIViewController: ORKTaskViewControllerDelegate, LocationDelegate {
    
    // MARK: - ORKTaskViewControllerDelegate Methods
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        
        let result = taskViewController.result
        
        switch reason {
        case .completed:
            
            if result.identifier == "registrationTask" {
                
                //Data Access Step (from HealthKit)
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let healthStore = delegate.healthStore
                healthStore?.requestAuthorization(toShare: nil, read: readDataTypes, completion: { (success, error) in
                    if !success {
                        print("Unexpected HealthKit Initialization Error: \(error)")
                    }
                })
                
                print("Ended Registration!")
                completedRegistration = true
            }
            
            fileAccessQueue.async(execute: {
                do {
                    let jsonData = try ORKESerializer.jsonData(for: result)
                    if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                        let path = mainDir.appendingPathComponent(logDataFile)
                        let fileHandle = try FileHandle(forWritingTo: path)
                        fileHandle.seekToEndOfFile()
                        let emptyLines = "\n\n\n"
                        let emptyData = emptyLines.data(using: String.Encoding.utf8)
                        fileHandle.write(emptyData!)
                        let data = jsonString.data(using: String.Encoding.utf8.rawValue)
                        fileHandle.write(data!)
                    }
                } catch let error as NSError {
                    print("Unresolved Serialization Writing Error: \(error), \(error.userInfo)")
                }
            })
            
            break
            
        default:
            break
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Location Delegate Methods
    
    // FIXME: (CURRENTLY NOT IN USE)
    func presentLocationRestrictedAlert() {
        let noAuthAlert = UIAlertController(title: "Oops!", message: "It seems you have restricted location access to this app, this could hinder the usefulness of it.", preferredStyle: .alert)
        let openPrefAction = UIAlertAction(title: "Open Preferences", style: .default) { _ in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        }
        let okayAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        noAuthAlert.addAction(openPrefAction)
        noAuthAlert.addAction(okayAction)
        present(noAuthAlert, animated: true, completion: nil)
    }
    
    // FIXME: (CURRENTLY NOT IN USE)
    func presentChangedAuthAlert() {
        let changedAuthAlert = UIAlertController(title: "Hey!", message: "It looks like you changed your privacy settings for this app, allowing location access will make this app a lot more useful", preferredStyle: .alert)
        let openPrefAction = UIAlertAction(title: "Open Preferences", style: .default) { (_) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        changedAuthAlert.addAction(openPrefAction)
        changedAuthAlert.addAction(cancelAction)
        present(changedAuthAlert, animated: true, completion: nil)
    }
    
    func reloadLocationData() {}
}

extension UIColor {
    convenience init(traditionalRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
}
