//
//  PermissionsTableViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/1/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class PermissionsTableViewController: UITableViewController {
    
    var permissions = [Permission]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location Cell
        let locationPermission = Permission(title: "Location", desc: "Allows the app to send you timely notifications when you are in a high or low green space area", enabled: nil)
        if location.checkLocationAuth() {
            locationPermission.buttonTitle = "Disable"
            locationPermission.enabled = true
        } else {
            locationPermission.buttonTitle = "Enable"
            locationPermission.enabled = false
        }
        permissions.append(locationPermission)
        
        // Notification Cell
        let notificationPermission = Permission(title: "Notifications", desc: "Allowing notifications enables the app to show you reminders and prompts to fill out a survey", enabled: nil)
        let notificationSettings = UIApplication.shared.currentUserNotificationSettings
        print(notificationSettings?.types as Any)
        if notificationSettings?.types.rawValue == 0 {
            print("no notification settings")
            notificationPermission.buttonTitle = "Enable"
            notificationPermission.enabled = false
        } else {
            print("some notification settings")
            notificationPermission.buttonTitle = "Disable"
            notificationPermission.enabled = true
        }
        permissions.append(notificationPermission)
        
        // Survey Cell
        let surveyPermission = Permission(title: "Survey Data", desc: "With this disabled, we will not collect your survey data", enabled: true)
        permissions.append(surveyPermission)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permissions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "permissionsCell", for: indexPath) as! PermissionsTableViewCell
        
        cell.titleLabel.text = permissions[indexPath.row].title
        cell.descriptionLabel.text = permissions[indexPath.row].desc
        cell.button.setTitle(permissions[indexPath.row].buttonTitle, for: [])
        
        cell.permission = permissions[indexPath.row]
        
        return cell
    }
}
