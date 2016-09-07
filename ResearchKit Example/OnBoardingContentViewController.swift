//
//  OnBoardingContentViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 8/4/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class OnBoardingContentViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var dataObject: String = ""
    
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: dataObject)
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)
    }

}
