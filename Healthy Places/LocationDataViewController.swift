//
//  LocationDataViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/6/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class LocationDataViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearLocationData))
        
        location.delegate = self
        reloadLocationData()
    }
    
    override func reloadLocationData() {
        fileAccessQueue.async {
            do {
                let locationString = try String.init(contentsOf: mainDir.appendingPathComponent(locationDataFile), encoding: String.Encoding.utf8)
                DispatchQueue.main.async(execute: {
                    self.textView.text = locationString
                })
                
            } catch let error as NSError {
                print("Location Data Read Error: \(error), \(error.userInfo)")
            }
        }
    }
    
    @objc func clearLocationData() {
        fileAccessQueue.async() {
            do {
                let emptyString = ""
                let path = mainDir.appendingPathComponent(locationDataFile)
                try emptyString.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        reloadLocationData()
    }
    
}
