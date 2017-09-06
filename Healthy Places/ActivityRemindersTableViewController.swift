//
//  ActivityRemindersTableViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 10/20/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class ActivityRemindersTableViewController: UITableViewController {
    
    @IBOutlet weak var notificationTimePicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    var showDatePicker = false
    var selectedString: String! = "9:00 AM"
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .short
        
        // Get time from remindersTimeFile
        fileAccessQueue.async {
            var fileString: String! = "9:00 AM"
            do {
                let path = mainDir.appendingPathComponent(remindersTimeFile)
                fileString = try String(contentsOf: path, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("new reminders file reading error: \(error)")
            }
            
            DispatchQueue.main.sync {
                let date = self.dateFormatter.date(from: fileString)
                if date == nil {
                    self.notificationTimePicker.date = Date()
                } else {
                    self.notificationTimePicker.date = date!
                    self.timeLabel.text = self.dateFormatter.string(from: date!)
                }
            }
        }
        
        notificationTimePicker.addTarget(self, action: #selector(updateView), for: .valueChanged)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //TODO: write to remindersTimeFile
        selectedString = dateFormatter.string(from: self.notificationTimePicker.date)
        write(string: self.selectedString, toNew: remindersTimeFile)
    }
    
    @objc func updateView() {
        DispatchQueue.main.async {
            let selectedString = self.dateFormatter.string(from: self.notificationTimePicker.date)
            self.timeLabel.text = selectedString
            self.tableView.reloadData()
        }
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
        if showDatePicker {
            return 3
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 1:
                showDatePicker = !showDatePicker
                break;
            default: break;
        }
        
        self.tableView.reloadData()
    }
    
}
