//
//  TasksTableViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/21/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit
import ResearchKit
import Foundation
import CoreLocation

class TasksTableViewController: UITableViewController, ORKPasscodeDelegate {
    
    let tableViewRows = ["Baseline Survey" : BaselineSurveyTask, "Green Space and Health Survey" : GreenspaceSurvey, "Daily Survey" : DailySurvey]
    
    var numberOfSurveys = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfSurveys = tableViewRows.count
        
        // TODO: TEMP FOR DONE BUTTON
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(goToOnboarding))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check Authorization Status
        fileAccessQueue.sync {
            do {
                let authDateString = try String(contentsOf: mainDir.appendingPathComponent(authDateFile), encoding: String.Encoding.utf8)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let authDate = dateFormatter.date(from: authDateString)
                if authDate != nil && (authDate?.timeIntervalSinceNow)! > Double(-securityTimeout) {
                    let authString = try String(contentsOf: mainDir.appendingPathComponent(authStatusFile), encoding: String.Encoding.utf8)
                    if authString == "true" {
                        let newAuthDateStr = String(describing: Date())
                        let datePath = mainDir.appendingPathComponent(authDateFile)
                        try newAuthDateStr.write(to: datePath, atomically: true, encoding: String.Encoding.utf8)
                        authenticated = true
                    } else {
                        authenticated = false
                    }
                }
            } catch let error as NSError {
                switch error.code {
                case 2, 260:
                    print("Auth file does not exist, do not attempt reading from this file")
                default:
                    print("Unresolved Auth Check Error: \(error), \(error.userInfo)")
                }
            }
        }
        
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() && !authenticated {
            let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Please authenticate to continue", delegate: self)
            present(passcodeViewController, animated: true, completion: nil)
        }
        
        // Check for required files (tasksCompleted) && check location auth
        fileAccessQueue.sync {
            do {
                let _ = try String(contentsOf: mainDir.appendingPathComponent(tasksCompletedFile))
            } catch let error as NSError {
                switch error.code {
                    case 2, 260:
                        print("Creating File: \(tasksCompletedFile)")
                        var tasksCompletedContent = ""
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        for _ in 1...numberOfSurveys {
                            tasksCompletedContent += "name\n"
                            tasksCompletedContent += "\(TaskStatus.notStarted.rawValue)\n"
                            tasksCompletedContent += "\(dateFormatter.string(from: Date()))\n"
                            tasksCompletedContent += "0\n"
                        }
                        write(string: tasksCompletedContent, toNew: tasksCompletedFile)
                        
                        // this is also a good time to check location auth, right?
                        let _ = location.checkLocationAuth()
                        
                        break
                    default:
                        print("Unresolved creation of required files initializer, \(error)")
                        break
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // TODO: TEMP FOR DONE BUTTON
    @objc func goToOnboarding() {
        let sb = UIStoryboard(name: "OnBoarding", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        vc?.modalTransitionStyle = .flipHorizontal
        present(vc!, animated: true, completion: nil)
    }
    
    // MARK: - Passcode Delegate Methods
    
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        print("Succeeded")
        
        fileAccessQueue.async() {
            let authStatus = "true"
            let authDate = String(describing: Date())
            do {
                let statusPath = mainDir.appendingPathComponent(authStatusFile)
                let datePath = mainDir.appendingPathComponent(authDateFile)
                try authStatus.write(to: statusPath, atomically: true, encoding: String.Encoding.utf8)
                try authDate.write(to: datePath, atomically: true, encoding: String.Encoding.utf8)
                authenticated = true
            } catch let error as NSError {
                switch error.code {
                case 2:
                    print("File does not exist, do not attempt reading from this file")
                default:
                    print("Unresolved Passcode Success Error: \(error), \(error.userInfo)")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
        print("Failed")
        
        fileAccessQueue.async() {
            let authStatus = "false"
            do {
                let path = mainDir.appendingPathComponent(authStatusFile)
                try authStatus.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                switch error.code {
                case 2, 260:
                    print("Auth file does not exist, do not attempt reading from this file")
                default:
                    print("Unresolved Passcode Fail Error: \(error), \(error.userInfo)")
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! SurveyTableViewCell
        let title = Array(tableViewRows.keys)[indexPath.row]
        var image: UIImage? = nil
        
        // Check file for last date the survey was taken
        var currentStatus: TaskStatus = .notStarted
        fileAccessQueue.sync {
            do {
                let taskFile = try String(contentsOf: mainDir.appendingPathComponent(tasksCompletedFile))
                var lines = taskFile.components(separatedBy: .newlines)
                
                /* lines:
                 *  [0] = name
                 *  [1] = last TaskStatus
                 *  [2] = date of last TaskStatus ^^
                 *  [3] = UUID if started, but not finished
                 */
                
                let numberOfParameters = 4
                let nameIndex = indexPath.row * numberOfParameters
                let statusIndex = (indexPath.row * numberOfParameters) + 1
                let dateIndex = (indexPath.row * numberOfParameters) + 2
//                let UUIDIndex = (indexPath.row * 4) + 3
                
                // check name and update file if different
                //get identifier
                let identifier = Array(tableViewRows.values)[indexPath.row].identifier
                if lines[nameIndex] != identifier {
                    lines[nameIndex] = identifier
                    var newContent = ""
                    for line in lines {
                        newContent += "\(line)\n"
                    }
                    write(string: newContent, toNew: tasksCompletedFile)
                }
                
                // get last task status
                let lastTaskStatus: TaskStatus = TaskStatus(rawValue: Int(lines[statusIndex])!)!
                
                // get last date from file and current date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let lastTaskDate = dateFormatter.date(from: lines[dateIndex])
                let currentDateString = dateFormatter.string(from: Date())
                let currentDate = dateFormatter.date(from: currentDateString)
               
                // check values to determine current status
                if lastTaskDate! < currentDate! || lastTaskStatus == .notStarted {
                    // Task hasn't been run today
                    currentStatus = .notStarted
                } else if lastTaskDate! == currentDate! && lastTaskStatus == .started {
                    // Task was started today but not finished
                    currentStatus = .started
                } else if lastTaskDate! == currentDate! && lastTaskStatus == .finished {
                    // Task was finished
                    currentStatus = .finished
                } else {
                    print("How?? If this happens fall back to notStarted")
                    currentStatus = .notStarted
                }
                
                // decide icon based on current status
                switch currentStatus {
                case .notStarted:
                    image = notStartedTaskImage()
                    break
                case .started:
                    image = #imageLiteral(resourceName: "unfinished_icon")
                    break
                case .finished:
                    image = #imageLiteral(resourceName: "completed_icon")
                    break
                }
                
            } catch let error {
                print("Unresolved checking last date taken error, \(error)")
            }
        }
        
        cell.titleLabel?.text = title
        cell.imageView?.image = image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = Array(tableViewRows.values)[indexPath.row]
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = mainDir
        present(taskViewController, animated: true, completion: nil)
    }
}
