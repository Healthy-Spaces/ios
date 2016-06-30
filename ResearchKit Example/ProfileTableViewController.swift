//
//  ProfileTableViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/22/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, ORKPasscodeDelegate {
    
    enum PasscodeMethod {
        case add
        case edit
        case remove
    }
    
    var profileSections: Dictionary<String, PasscodeMethod> = [:]
    var removePass = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        profileSections.removeAll()
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            profileSections["Edit Passcode"] = .edit
            profileSections["Remove Passcode"] = .remove
        } else {
            profileSections["Add Passcode"] = .add
        }
        self.tableView.reloadData()
    }
    
    // MARK: - ORKPasscode Delegate Methods
    
    func addPasscode() {
        let taskViewController = ORKTaskViewController(task: AddPasscodeTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = FileManager.default().urlsForDirectory(.documentDirectory, inDomains: .userDomainMask).first!
        present(taskViewController, animated: true, completion: nil)
    }
    
    func editPasscode() {
        let passcodeViewController = ORKPasscodeViewController.passcodeEditingViewController(withText: "Enter a new passcode", delegate: self, passcodeType: .type6Digit)
        present(passcodeViewController as! ORKPasscodeViewController, animated: true, completion: nil)
    }
    
    func removePasscode() {
        removePass = true
        let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Please authenticate to remove passcode", delegate: self)
        present(passcodeViewController as! ORKPasscodeViewController, animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        print("Success!")
        if removePass {
            ORKPasscodeViewController.removePasscodeFromKeychain()
        }
        removePass = false
        loadData()
        dismiss(animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
        removePass = false
        print("Failed")
    }
    
    func passcodeViewControllerDidCancel(_ viewController: UIViewController) {
        removePass = false
        print("Canceled")
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileSections.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        let title = Array(profileSections.keys)[indexPath.row]
        
        cell.textLabel?.text = title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let passFunc = Array(profileSections.values)[indexPath.row]
        
        switch passFunc {
        case .add:
            addPasscode()
            break
        case .edit:
            editPasscode()
            break
        case .remove:
            removePasscode()
            break
        }
    }
}
