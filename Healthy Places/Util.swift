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

public func append(data: Data, toOld file: String) {
    do {
        let path = mainDir.appendingPathComponent(file)
        let fileHandle = try FileHandle(forWritingTo: path)
        fileHandle.seekToEndOfFile()
        fileHandle.write(data)
    } catch let error as NSError {
        print("Unexpected AppendToOldFile error: \(error), \(error.userInfo)")
    }
}

public func upload(data: NSMutableDictionary, completion: @escaping (_ result: String, _ code: Int) -> Void) {
    networkingQueue.async {
        do {
            let jsonData = try ORKESerializer.jsonData(for: data)
            let uploadSession = NetworkSession()
            uploadSession.dataRequest(with: jsonData) { (result: String, code: Int) in
                completion(result, code)
            }
        } catch let error as NSError {
            print("Unexpected Serialization Error in Upload: \(error), \(error.userInfo)")
        }
    }
}

public func saveJSONData(data: NSMutableDictionary, completion: @escaping (_ success: Bool) -> Void) {
    fileAccessQueue.async {
        do {
            
            let jsonData = try ORKESerializer.jsonData(for: data);
            
//            if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
//                write(string: jsonString as String, toNew: logDataFile)
//                completion(true)
//            } else {
//                completion(false)
//            }
            
            append(data: jsonData, toOld: logDataFile)
            
//            let path = mainDir.appendingPathComponent(logDataFile)
//            let fileHandle = try FileHandle(forWritingTo: path)
//            fileHandle.seekToEndOfFile()
//            fileHandle.write(jsonData)
            
        } catch let error as NSError {
            print("Unexpected Serialization Error in SaveJSONData: \(error), \(error.userInfo)")
            completion(false)
        }
    }
}

public func getWeekdays() -> [String] {
    // get days of the week
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    let days = calendar.weekdaySymbols
    
    return days
}

public func getWeeklyTracker() -> [String: Any]? {
    do {
        let weeklyTrackterString = try String(contentsOf: mainDir.appendingPathComponent(dailySurveyTaken))
        var weeklySurveyDict = convertToDictionary(text: weeklyTrackterString)
        return weeklySurveyDict
    } catch let error as NSError {
        print("Unresolved getWeeklyTracker() Error: \(error), \(error.userInfo)")
        return nil
    }
}

public func weeklyTrackerInit() {
    // initialize weekly tracker
    let json = NSMutableDictionary()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-dd-mm"
    json.setObject(formatter.string(from: getSunday()), forKey: "startDate" as NSCopying)
    
    let days = getWeekdays()
    
    // set all days to false
    for day in days {
        json.setObject(false, forKey: day.lowercased() as NSCopying)
    }
    
    // write to file
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: .utf8)
        write(string: jsonString!, toNew: dailySurveyTaken)
    } catch let error as NSError {
        print("Unresolved Weekly Tracker Initializer Error: \(error), \(error.userInfo)")
    }
}

public func displayUploadError(vc: UIViewController) {
    let alert = UIAlertController(title: "Uh Oh!", message: "Your survey failed to upload! We'll try again later for you!", preferredStyle: .alert)
    let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
    alert.addAction(okayAction)
    vc.present(alert, animated: true, completion: nil)
}

func setNameAndEmail() {
    let json = NSMutableDictionary()
    json.setObject("getNameAndEmail", forKey: "task" as NSCopying)
    let uid = UserDefaults.standard.object(forKey: "userID")
    json.setObject(uid!, forKey: "uid" as NSCopying)
    
    upload(data: json) { (response, code) in
        if code == 0 {
            let responseDictionary = convertToDictionary(text: response)
            let email = responseDictionary?["email"] as? String
            let givenName = responseDictionary?["givenName"] as? String
            let familyName = responseDictionary?["familyName"] as? String
            
            let name = givenName! + " " + familyName!
            
            UserDefaults.standard.set(name, forKey: ("name" as NSCopying) as! String)
            UserDefaults.standard.set(email, forKey: ("email" as NSCopying) as! String)
            UserDefaults.standard.synchronize()
        }
    }
}

public func setupHealthKit() {
    //Data Access Step (from HealthKit)
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let healthStore = delegate.healthStore
    healthStore?.requestAuthorization(toShare: nil, read: readDataTypes, completion: { (success, error) in
        if !success {
            print("Unexpected HealthKit Initialization Error: \(String(describing: error))")
        }
    })
}

// TODO: writeToRetry
public func writeToRetry(data: NSMutableDictionary) {}

public func isRetryEmpty() -> Bool? {
    // get retry data
    do {
        let retryString = try String(contentsOf: mainDir.appendingPathComponent(retryFile))
        if retryString.isEmpty {
            return true
        } else {
            let retryData = convertToDictionary(text: retryString)
            uploadRetry(data: retryData as! NSMutableDictionary)
        }
    } catch let error as NSError {
        print("Unresolved Check Retry Error: \(error), \(error.userInfo)")
    }
    
    return nil
    
}

// TODO: Upload Retry
public func uploadRetry(data: NSMutableDictionary) { }

public func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

public func getSunday() -> Date {
    return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
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
        let json = NSMutableDictionary()
        
        switch reason {
        case .completed:
            
            // Check if a main survey, if so update tasksCompletedFile
            switch result.identifier {
                
                // check if just registered
                case RegistrationTask.identifier:
                    
                    setupHealthKit()
                    
//                    //Data Access Step (from HealthKit)
//                    let delegate = UIApplication.shared.delegate as! AppDelegate
//                    let healthStore = delegate.healthStore
//                    healthStore?.requestAuthorization(toShare: nil, read: readDataTypes, completion: { (success, error) in
//                        if !success {
//                            print("Unexpected HealthKit Initialization Error: \(String(describing: error))")
//                        }
//                    })
                    
                    UserDefaults.standard.setValue(true, forKey: "hasRegistered")
                    UserDefaults.standard.synchronize()
                    print("Ended Registration!")
                    completedRegistration = true
                    
                    // build registration JSON
                    json.setObject("register", forKey: "task" as NSCopying)
                    json.setObject(result, forKey: "data" as NSCopying)
                    
                    // save JSON
                    saveJSONData(data: json, completion: { (success) in
                        if !success {
                            print("registration save failure")
                        } else {
                            print("registration save success")
                        }
                    })
                    
                    // upload JSON
                    upload(data: json, completion: { (result, code) in
                        if code == 0 {
                            // success
                            let resultDictionary = convertToDictionary(text: result)
                            var newID = resultDictionary?["uid"]
                            
                            //FIXME: TEMP FOR ID NOT SET, NEEDS ERROR HANDLING
                            if newID == nil {
                                newID = "404"
                            }
                            
                            if newID != nil {
                                print("New ID: \(newID!)")
                                UserDefaults.standard.setValue(newID!, forKey: "userID")
                                UserDefaults.standard.synchronize()
                                
                                setNameAndEmail()
                            }
                        } else {
                            DispatchQueue.main.async {
                                displayUploadError(vc: self)
                            }
                        }
                    })
                    
                    break
                
                case "loginTask": // login task
                    
                    json.setObject("login", forKey: "task" as NSCopying)
                    json.setObject(result, forKey: "data" as NSCopying)
                                    
                    saveJSONData(data: json, completion: { (success) in
                        if !success {
                            print("login save failure")
                        } else {
                            print("login save success")
                        }
                    })
                    
                    upload(data: json, completion: { (result, code) in
                        if code == 0 {
                            let resultDictionary = convertToDictionary(text: result)
                            let newID = resultDictionary?["uid"] as? String
                            if (newID == nil) {
                                
                                // alert the user of failure
                                DispatchQueue.main.async {
                                    let alert = UIAlertController(title: "Uh Oh!", message: "Login Failed! Wanna try again?", preferredStyle: .alert)
                                    let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                                    alert.addAction(okayAction)
                                    self.present(alert, animated: true, completion: nil)
                                }
                                print("Login Failed")
                                return
                            }
                            
                            let id = Int(newID!)
                            UserDefaults.standard.setValue(id, forKey: "userID")
                            UserDefaults.standard.setValue(true, forKey: "hasRegistered")
                            UserDefaults.standard.synchronize()
                            
                            completedRegistration = true
                            
                            DispatchQueue.main.async {
                                setNameAndEmail()
                                setupHealthKit()
                            }
                        } else {
                            DispatchQueue.main.async {
                                displayUploadError(vc: self)
                            }
                        }
                    })
                    
                    break
                
                
                default:
                    
                    // Update tasksCompletedFile
                    /* tasksCompleted File Structure:
                     For each survey:
                         [a] = name of survey
                         [b] = last TaskStatus
                         [c] = date of last TaskStatus ^^
                         [d] = UUID if started, but not finished
                     
                     Find x, y, z by using two for-loops
                     */
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
                    
                    // write to weekly tracker
                    /* Weekly Tracker Format:
                     {
                         "startDate": "2017-10-15 23:06:51",
                         "sunday": true,
                         "monday": true,
                         "tuesday": true,
                         "wednesday": false,
                         "thursday": true,
                         "friday": false,
                         "saturday": false
                     }
                    */
                    fileAccessQueue.async {
                        do {
                            // get weekly tracker file
                            var surveyTrackerDict = getWeeklyTracker()
                            
                            // get last Sunday's date
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-dd-mm"
                            let lastSunday = formatter.string(from: getSunday())
                            
                            // check if in this week (if not, set new date)
                            if lastSunday != surveyTrackerDict!["startDate"] as? String {
                                // set new date and reset days
                                surveyTrackerDict!["startDate"] = lastSunday
                                for (key, _) in surveyTrackerDict! {
                                    if key != "startDate" {
                                        surveyTrackerDict![key] = false
                                    }
                                }
                            }
                            
                            // set todays day as completed
                            formatter.dateFormat = "EEEE"
                            let todaysName = formatter.string(from: Date()).lowercased()
                            surveyTrackerDict![todaysName] = true
                            
                            // write updated file
                            let newSurveyTrackerData = try JSONSerialization.data(withJSONObject: surveyTrackerDict!, options: .prettyPrinted)
                            let newSurveyTrackerString = String(data: newSurveyTrackerData, encoding: .utf8)
                            write(string: newSurveyTrackerString!, toNew: dailySurveyTaken)
                        } catch let error {
                            print("Unresolved updating \(dailySurveyTaken), \(error)")
                        }
                    }
                    
                    // build task JSON
                    var id = UserDefaults.standard.value(forKey: "userID")
                    
                    //FIXME: TEMP FOR ID NOT SET, NEEDS ERROR HANDLING
                    if id == nil {
                        id = "404"
                    }
                    
                    json.setObject("saveSurvey", forKey: "task" as NSCopying)
                    json.setObject(id!, forKey: "userID" as NSCopying)
                    json.setObject(result, forKey: "data" as NSCopying)
                    
                    // Save to device
                    saveJSONData(data: json, completion: { (success) in
                        if !success {
                            print("Survey Save Failure")
                        } else {
                            print("Survey Save Success")
                        }
                    })
                    
                    // Upload to server
                    upload(data: json, completion: { (response, code) in
                        if code == 0 {
                            let responseDictionary = convertToDictionary(text: response)
                            let successString = responseDictionary?["success"] as? String
                            var success = true
                            if successString != "true" {
                                success = false
                            }
                            if !success {
                                // TODO: upload failure, retry later
                                
                                // alert the user of failure
                                DispatchQueue.main.async {
                                    displayUploadError(vc: self)
                                }
                                print("Survey Upload Failure")
                            } else {
                                print("Survey Upload Success")
                            }
                        } else {
                            displayUploadError(vc: self)
                        }
                    })
                    
                    break
            }
            
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
