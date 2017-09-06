//
//  ProfileTableViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/22/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, ORKPasscodeDelegate, ProfileNameTableViewCellDelegate {
    
    enum Method {
        case addPass
        case editPass
        case removePass
        case changePermissions
        case sharingOptions
        case locationData
        case lastImageTaken
        case logData
    }
    
    var profileSections: Dictionary<String, Method> = [:]
    var removePass = false
    
    // Get HealthKit HealthStore
    var healthStore: HKHealthStore {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.healthStore!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
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
            profileSections["Edit Passcode"] = .editPass
            profileSections["Remove Passcode"] = .removePass
        } else {
            profileSections["Add Passcode"] = .addPass
        }
        
        profileSections["Permissions"] = .changePermissions
        profileSections["Sharing Options"] = .sharingOptions
        profileSections["Location Data"] = .locationData
        profileSections["Log Data"] = .logData
        profileSections["Last Image Taken"] = .lastImageTaken
        
        self.tableView.reloadData()
    }
    
    // MARK: - ProfileNameTableViewCellDelegate Methods
    
    func leaveStudyButtonPressed() {
        let withdrawAlert = UIAlertController(title: "Withdraw", message: "Are you sure you want to completely withdraw from the study?\nThis action cannot be undone.", preferredStyle: .actionSheet)
        let withdrawAction = UIAlertAction(title: "Withdraw", style: .destructive) { (_) in
            UserDefaults.standard.removeObject(forKey: "userID")
            UserDefaults.standard.removeObject(forKey: "hasRegistered")
            UserDefaults.standard.synchronize()
                        
            if !UserDefaults.standard.bool(forKey: "hasRegistered") {
                let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
                let controller = storyboard.instantiateInitialViewController()
                self.present(controller!, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        withdrawAlert.addAction(withdrawAction)
        withdrawAlert.addAction(cancelAction)
        present(withdrawAlert, animated: true, completion: nil)
    }
    
    // MARK: - ORKPasscode Delegate Methods
    
    func addPasscode() {
        let taskViewController = ORKTaskViewController(task: AddPasscodeTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        present(taskViewController, animated: true, completion: nil)
    }
    
    func editPasscode() {
        let passcodeViewController = ORKPasscodeViewController.passcodeEditingViewController(withText: "Enter a new passcode", delegate: self, passcodeType: .type6Digit)
        present(passcodeViewController, animated: true, completion: nil)
    }
    
    func removePasscode() {
        removePass = true
        let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Please authenticate to remove passcode", delegate: self)
        present(passcodeViewController, animated: true, completion: nil)
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
    
    // MARK: - Permission Methods
    
    func presentPermissionsViewController() {
        performSegue(withIdentifier: "permissionsSegue", sender: self)
    }
    
    // MARK: - Sharing Methods
    
    func presentSharingOptions() {
        let root = UINavigationController()
        let stepViewController = ORKQuestionStepViewController(step: SharingOptionsStep)
        root.addChildViewController(stepViewController)
        stepViewController.title = "Sharing Options"
        stepViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissRootVC))
        present(root, animated: true, completion: nil)
    }
    
    func presentActivityReminders() {
        performSegue(withIdentifier: "activityRemindersSegue", sender: self)
    }
    
    @objc func dismissRootVC() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Location Methods
    
    func presentLocationData() {
        performSegue(withIdentifier: "locationSegue", sender: self)
    }
    
    // MARK: - Image Methods
    
    func presentImageVC() {
        performSegue(withIdentifier: "lastImageSegue", sender: self)
    }
    
    // MARK: - Log Data Methods
    
    func presentLogData() {
        performSegue(withIdentifier: "logDataSegue", sender: self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 5 // Profile Information
        case 1: return 1 // Activity Reminders
        case 2:          // Passcode Options + Sharing Options
            if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                return 3
            } else {
                return 2
            }
        case 3: return 2 // Permissions + Consent
        case 4: return 2 // Privacy Policy + License (ResearchKit + our own license)
        
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                
            /* PROFILE INFORMATION */
            case 0:
                //TODO: Get name and email from registration
                let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! ProfileNameTableViewCell
                cell.delegate = self
                
                
                
                let name = UserDefaults.standard.object(forKey: "name")
                let email = UserDefaults.standard.object(forKey: "email")
                
                cell.nameLabel.text = name as! String?
                cell.emailLabel.text = email as! String?
                
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "birthdateCell") as! DemographicTableViewCell
                
                // Get Birthday
                var birthdayString: String
                do {
                    let birthday = try healthStore.dateOfBirth()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM dd, yyyy"
                    birthdayString = dateFormatter.string(from: birthday)
                } catch let error {
                    print("Unresolved Birthday Access Error: \(error)")
                    birthdayString = "Not Set"
                }
                
                cell.demographicLabel.text = birthdayString
                
                cell.selectionStyle = .none
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "bioSexCell") as! DemographicTableViewCell
                
                // Get Sex
                var sexString: String
                do {
                    let sex = try healthStore.biologicalSex()
                    switch sex.biologicalSex {
                    case .female:
                        sexString = "Female"
                        break
                    case .male:
                        sexString = "Male"
                        break
                    case .other:
                        sexString = "Other"
                        break
                    default:
                        sexString = "Not Set"
                        break
                    }
                } catch let error {
                    print("Unresolved Sex Access Error: \(error)")
                    sexString = "Not Set"
                }
                
                cell.demographicLabel.text = sexString
                
                cell.selectionStyle = .none
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "heightCell") as! DemographicTableViewCell
                
                // Get Height
                var heightString = "Not Set"
                let sampleType = HKSampleType.quantityType(forIdentifier: .height)
                readMostRecentSample(sampleType: sampleType!, completion: { (mostRecentHeight, error) in
                    if error != nil {
                        print("Unresolved Height Access Error: \(String(describing: error))")
                        return
                    }
                    
                    let height = mostRecentHeight as? HKQuantitySample
                    
                    if let meters = height?.quantity.doubleValue(for: .meter()) {
                        let heightFormatter = LengthFormatter()
                        heightFormatter.isForPersonHeightUse = true
                        heightString = heightFormatter.string(fromMeters: meters)
                    }
                    
                    DispatchQueue.main.async {
                        cell.demographicLabel.text = heightString
                    }
                })
                
                cell.selectionStyle = .none
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "weightCell") as! DemographicTableViewCell
                
                // Get Weight
                var weightString = "Not Set"
                let sampleType = HKSampleType.quantityType(forIdentifier: .bodyMass)
                readMostRecentSample(sampleType: sampleType!, completion: { (mostRecentWeight, error) in
                    if error != nil {
                        print("Unresolved Height Access Error: \(String(describing: error))")
                        return
                    }
                    
                    let weight = mostRecentWeight as? HKQuantitySample
                    
                    if let kilograms = weight?.quantity.doubleValue(for: .gramUnit(with: .kilo)) {
                        let weightFormatter = MassFormatter()
                        weightFormatter.isForPersonMassUse = true
                        weightString = weightFormatter.string(fromKilograms: kilograms)
                    }
                    
                    DispatchQueue.main.async {
                        cell.demographicLabel.text = weightString
                    }
                })
                
                cell.selectionStyle = .none
                return cell
                
            default: return defaultCell(withIdentifier: "errorCell", title: "An Error Occurred", disclosureIndicator: false)
            }
            
        /* ACTIVITY REMINDERS */
        case 1:
            switch indexPath.row {
            case 0: return defaultCell(withIdentifier: "activityRemindersCell", title: "Activity Reminders", disclosureIndicator: true)
            default: return defaultCell(withIdentifier: "errorCell", title: "An Error Occurred", disclosureIndicator: false)
            }
            
        /* PASSCODE + SHARING OPTIONS */
        case 2:
            switch indexPath.row {
            case 0:
                if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                    return defaultCell(withIdentifier: "passcodeCell", title: "Change Passcode", disclosureIndicator: false)
                } else {
                    return defaultCell(withIdentifier: "passcodeCell", title: "Add Passcode", disclosureIndicator: false)
                }
            case 1:
                if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                    return defaultCell(withIdentifier: "removePasscodeCell", title: "Remove Passcode", disclosureIndicator: false)
                } else {
                    return defaultCell(withIdentifier: "sharingOptionsCell", title: "Sharing Options", disclosureIndicator: false)
                }
            case 2:
                if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                    return defaultCell(withIdentifier: "sharingOptionsCell", title: "Sharing Options", disclosureIndicator: false)
                } else {
                    return defaultCell(withIdentifier: "errorCell", title: "An Error Occurred", disclosureIndicator: false)
                }
            default: return defaultCell(withIdentifier: "errorCell", title: "An Error Occurred", disclosureIndicator: false)
            }
            
        /* PERMISSIONS + CONSENT */
        case 3:
            switch indexPath.row {
            case 0: return defaultCell(withIdentifier: "permissionsCell", title: "Permissions", disclosureIndicator: true)
            case 1: return defaultCell(withIdentifier: "consentCell", title: "Review Consent", disclosureIndicator: true)
            default: return defaultCell(withIdentifier: "errorCell", title: "An Error Occurred", disclosureIndicator: false)
            }
            
        /* PRIVACY POLICY + LICENSE INFORMATION */
        case 4:
            switch indexPath.row {
            case 0: return defaultCell(withIdentifier: "privacyPolicyCell", title: "Privacy Policy", disclosureIndicator: true)
            case 1: return defaultCell(withIdentifier: "licenseCell", title: "License Information", disclosureIndicator: true)
            default: return defaultCell(withIdentifier: "errorCell", title: "An Error Occurred", disclosureIndicator: false)
            }
        default: return defaultCell(withIdentifier: "errorCell", title: "An Error Occurred", disclosureIndicator: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                presentActivityReminders()
                return
            default:
                return
            }
        case 2:
            switch indexPath.row {
            case 0:
                if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                    editPasscode()
                } else {
                    addPasscode()
                }
                return
            case 1:
                if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                    removePasscode()
                } else {
                    presentSharingOptions()
                }
                return
            case 2:
                presentSharingOptions()
                return
            default:
                return
            }
        case 3:
            switch indexPath.row {
            case 0:
                presentPermissionsViewController()
                return
            case 1:
                let consentDocument = ConsentDocument
                let consentSlidesTask = ORKVisualConsentStep(identifier: "consentSlides", document: consentDocument)
                let task = ORKOrderedTask(identifier: "consentSlidesTask", steps: [consentSlidesTask])
                let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
                taskViewController.delegate = self
                taskViewController.outputDirectory = mainDir
                present(taskViewController, animated: true, completion: nil)
                return
            default:
                return
            }
        case 4:
            switch indexPath.row {
            case 0:
                //TODO: Show Privacy Policy
                print("Showing Privacy Policy")
                return
            case 1:
                //TODO: Show Licenses
                print("Showing Licenses")
                return
            default:
                return
            }
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 130
        } else {
            return 70
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.alpha = 0
        return view
    }
}
