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
            let imagePath = mainDir.appendingPathComponent("imageCaptureStep.jpg")
            let image = UIImage(contentsOfFile: imagePath.path)
            
            DispatchQueue.main.async(execute: { 
                self.imageView.image = image
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
