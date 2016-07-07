//
//  Permission.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/1/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class Permission: NSObject {
    
    var enabled: Bool? = nil
    var title: String? = nil
    var desc: String? = nil
    var buttonTitle: String? = nil
    
    init(title: String, desc: String?, enabled: Bool?) {
        self.title      = title
        self.desc       = desc
        self.enabled    = enabled
        if enabled != nil && enabled! {
            buttonTitle = "Disable"
        } else if enabled != nil && !enabled! {
            buttonTitle = "Enable"
        }
    }
    
    func enable(_ function: String) {
        switch function {
        case "location":
            print("enabling location tracking")
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared().openURL(url)
            } else {
                print("couldn't open preferences")
            }
            break
        default:
            // do nothing
            break
        }
        
        enabled = true
        buttonTitle = "Disable"
    }
    
    func disable(_ function: String) {
        switch function {
        case "location":
            print("disable location tracking")
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared().openURL(url)
            } else {
                print("couldn't open preferences")
            }
            break
        default:
            break
        }
        
        enabled = false
        buttonTitle = "Enable"
    }
}
