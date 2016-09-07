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
    
    let tableViewRows = ["Consent" : ConsentTask, "Image Capture" : ImageCaptureTask, "Survey" : SurveyTask, "Location Task" : LocationTask]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: TEMP FOR DONE BUTTON
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(goToOnboarding))
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
                if authDate != nil && (authDate?.timeIntervalSinceNow)! > Double(-1000) {
                    let authString = try String.init(contentsOf: mainDir.appendingPathComponent(authStatusFile), encoding: String.Encoding.utf8)
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
                    print("File does not exist, do not attempt reading from this file")
                default:
                    print("Unresolved Auth Check Error: \(error), \(error.userInfo)")
                }
            }
        }
        
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() && !authenticated {
            let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Please authenticate to continue", delegate: self)
            present(passcodeViewController as! ORKPasscodeViewController, animated: true, completion: nil)
        }
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
                case 2:
                    print("File does not exist, do not attempt reading from this file")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        let title = Array(tableViewRows.keys)[indexPath.row]
        
        cell.textLabel?.text = title

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
