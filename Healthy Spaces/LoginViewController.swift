//
//  LoginViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 8/22/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit
import ResearchKit

class LoginViewController: ORKLoginStepViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func forgotPasswordButtonTapped() {
        let sb = UIStoryboard(name: "OnBoarding", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "forgotPassNavController")
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }

}
