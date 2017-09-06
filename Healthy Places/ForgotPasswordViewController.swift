//
//  ForgotPasswordViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 9/13/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetPassButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            
            //Display error if empty
            let alert = UIAlertController(title: "Uh Oh!", message: "You haven't entered an email address!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        //TODO: If email is available, send to server
        networkingQueue.async {
            print("Sending \(email) to server")
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
