//
//  LastImageViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/7/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class LastImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fileAccessQueue.async { 
            do {
                let imagePath = try mainDir.appendingPathComponent("imageCaptureStep.jpg")
                let image = UIImage(contentsOfFile: imagePath.path!)
                
                DispatchQueue.main.async(execute: { 
                    self.imageView.image = image
                })
                
            } catch let error as NSError {
                print("Image Access Error: \(error), \(error.userInfo)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
