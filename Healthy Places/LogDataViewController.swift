//
//  LogDataViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/8/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class LogDataViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearData))
        self.reloadData()
    }
    
    func reloadData() {
        fileAccessQueue.async {
            do {
                let logString = try String.init(contentsOf: mainDir.appendingPathComponent(logDataFile), encoding: String.Encoding.utf8)
                DispatchQueue.main.async(execute: {
                    self.textView.text = logString
                })
                
            } catch let error as NSError {
                print("Log Data Read Error: \(error), \(error.userInfo)")
            }
        }
    }
    
    @objc func clearData() {
        fileAccessQueue.async() {
            do {
                let emptyString = ""
                let path = mainDir.appendingPathComponent(logDataFile)
                try emptyString.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        reloadData()
    }

}
