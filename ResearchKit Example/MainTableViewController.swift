//
//  MainTableViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/21/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit
import ResearchKit
import Foundation

class MainTableViewController: UITableViewController, ORKPasscodeDelegate {
    
    let tableViewRows = ["Consent" : ConsentTask, "Image Capture" : ImageCaptureTask, "Survey" : SurveyTask]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fileAccessQueue.sync {
            do {
                let authDateString = try String(contentsOf: mainDir.appendingPathComponent(authDateFile), encoding: String.Encoding.utf8)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let authDate = dateFormatter.date(from: authDateString)
                if authDate != nil && authDate?.timeIntervalSinceNow > -1000 {
                    let authString = try String.init(contentsOf: mainDir.appendingPathComponent(authStatusFile), encoding: String.Encoding.utf8)
                    if authString == "true" {
                        let newAuthDateStr = String(Date())
                        let datePath = try mainDir.appendingPathComponent(authDateFile)
                        try newAuthDateStr.write(to: datePath, atomically: true, encoding: String.Encoding.utf8)
                        authenticated = true
                    } else {
                        authenticated = false
                    }
                }
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() && !authenticated {
            let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Please authenticate to continue", delegate: self)
            present(passcodeViewController as! ORKPasscodeViewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Passcode Delegate Methods
    
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        print("Succeeded")
        
        fileAccessQueue.async() {
            let authStatus = "true"
            let authDate = String(Date())
            do {
                let statusPath = try mainDir.appendingPathComponent(authStatusFile)
                let datePath = try mainDir.appendingPathComponent(authDateFile)
                try authStatus.write(to: statusPath, atomically: true, encoding: String.Encoding.utf8)
                try authDate.write(to: datePath, atomically: true, encoding: String.Encoding.utf8)
                authenticated = true
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
        print("Failed")
        
        fileAccessQueue.async() {
            let authStatus = "false"
            do {
                let path = try mainDir.appendingPathComponent(authStatusFile)
                try authStatus.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
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

extension UITableViewController: ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result
        
        switch reason {
        case .completed:
            let result = taskViewController.result
            
            let jsonData = try! ORKESerializer.jsonData(for: result)
            if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                print(jsonString)
            }
            
            break
        case .saved, .failed, .discarded:
            break
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
