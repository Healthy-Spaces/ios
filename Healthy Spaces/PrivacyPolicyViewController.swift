//
//  PrivacyPolicyViewController.swift
//  Healthy Spaces
//
//  Created by Samuel Lichlyter on 11/21/17.
//  Copyright © 2017 Samuel Lichlyter. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let pdf = Bundle.main.url(forResource: "privacyPolicy", withExtension: "pdf") {
            let request = URLRequest(url: pdf)
            self.webView.loadRequest(request)
        }
    }
}
