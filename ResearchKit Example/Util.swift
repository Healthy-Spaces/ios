//
//  Util.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/8/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

public func write(string: String, toNew file: String) {
    do {
        let path = mainDir.appendingPathComponent(file)
        try string.write(to: path, atomically: true, encoding: String.Encoding.utf8)
    } catch let error {
        print("new string new file writing error: \(error)")
    }
}

public func upload(data: Data, completion: @escaping (_ result: String, _ code: Int) -> Void) {
    networkingQueue.async {
        let uploadSession = NetworkSession()
        uploadSession.dataRequest(with: data) { (result: String, code: Int) in
            completion(result, code)
        }
    }
}

public func defaultCell(withIdentifier identifier: String, title: String, disclosureIndicator: Bool) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
    cell.textLabel?.text = title
    if disclosureIndicator {
        cell.accessoryType = .disclosureIndicator
    }
    
    return cell
}

public extension UIImage {
    public convenience init?(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgimage = image?.cgImage else { return nil }
        self.init(cgImage: cgimage)
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

public func notStartedTaskImage() -> UIImage {
    let size = CGSize(width: 45, height: 44)
    let size2 = CGSize(width: 22, height: 22)
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()
    let rect = CGRect(origin: CGPoint(x: 1, y: 11), size: size2)

    context?.setFillColor(UIColor.clear.cgColor)
    context?.setStrokeColor(UIColor.gray.cgColor)
    context?.setLineWidth(1.0)
    context?.addEllipse(in: rect)
    context?.drawPath(using: .fillStroke)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

extension UIColor {
    convenience init(traditionalRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
}

extension UIViewController: ORKTaskViewControllerDelegate, LocationDelegate {
    
    // MARK: - ORKTaskViewControllerDelegate Methods
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        
        let result = taskViewController.result
        
        switch reason {
        case .completed:
            
            // Check if a main survey, if so update tasksCompletedFile
            switch result.identifier {
                
                // check if just registered
                case RegistrationTask.identifier:
                    
                    //Data Access Step (from HealthKit)
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    let healthStore = delegate.healthStore
                    healthStore?.requestAuthorization(toShare: nil, read: readDataTypes, completion: { (success, error) in
                        if !success {
                            print("Unexpected HealthKit Initialization Error: \(error)")
                        }
                    })
                    
                    UserDefaults.standard.setValue(true, forKey: "hasRegistered")
                    print("Ended Registration!")
                    completedRegistration = true
                    
                    break
                
                case BaselineSurveyTask.identifier, GreenspaceSurvey.identifier, DailySurvey.identifier:
                    
                    // Update tasksCompletedFile
                    fileAccessQueue.async {
                        do {
                            let taskFile = try String(contentsOf: mainDir.appendingPathComponent(tasksCompletedFile))
                            var lines = taskFile.components(separatedBy: .newlines)
                            for index in 0...lines.count {
                                if lines[index] == result.identifier {
                                    
                                    // set task status to completed
                                    lines[index + 1] = String(TaskStatus.finished.rawValue)
                                    
                                    // update date
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd"
                                    let todayString = dateFormatter.string(from: Date())
                                    lines[index + 2] = todayString
                                    
                                    // generate new string
                                    var newContent = ""
                                    for line in lines {
                                        newContent += "\(line)\n"
                                    }
                                    
                                    // write to file
                                    write(string: newContent, toNew: tasksCompletedFile)
                                    
                                    // break out of this for-loop, we've done our business here
                                    break
                                }
                            }
                        } catch let error {
                            print("Unresolved updating \(tasksCompletedFile), \(error)")
                        }
                    }
                    break
                
                default:
                    break
            }
            
            // Write data to file
            // TODO: encrypt this
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
                        
                        // TODO: encrypt data
                        
                        
                        // upload to server function call
                        upload(data: data!, completion: { (result, code) in
                            if code == 0 {
                                // SUCCESS! DO NOTHING?
                                print("Success!")
                            } else {
                                // TODO: FAILURE! RETRY LATER
                                print("Failure!")
                            }
                            
                            print(result)
                        })
                    }
                } catch let error as NSError {
                    print("Unresolved Serialization Writing Error: \(error), \(error.userInfo)")
                }
            })
            
            print("Ended \(result.identifier) task")
            
            break
            
        default:
            break
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - HealthKit Convenience Methods
    func readMostRecentSample(sampleType: HKSampleType, completion: ((HKSample?, Error?) -> Void)!) {
        let past = Date.distantPast
        let now = Date()
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: past, end: now, options: [])
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            let mostRecentSample = results?.first as? HKQuantitySample
            
            if completion != nil {
                completion(mostRecentSample, nil)
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let healthStore = appDelegate.healthStore
        healthStore?.execute(sampleQuery)
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
