//
//  PermissionsTableViewCell.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/1/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class PermissionsTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    var permission: Permission?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure button style
        button.layer.backgroundColor = UIColor.clear().cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = tintColor.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    @IBAction func buttonAction(_ sender: AnyObject) {
        let feature = titleLabel.text?.lowercased()
        if permission?.enabled != nil && (permission?.enabled!)! {
            print("Disabling \(feature!)")
            permission?.disable(feature!)
        } else if permission?.enabled != nil && !(permission?.enabled!)! {
            print("Enabling \(feature!)")
            permission?.enable(feature!)
        } else {
            print("permission?.enabled == nil")
        }
        
        loadData()
    }
    
    func loadData() {
        print("permission.enabled: \((permission?.enabled!)!)")
        if permission?.enabled != nil && (permission?.enabled!)! {
            print("Changing to Disable")
            button.setTitle("Disable", for: .normal)
        } else if permission?.enabled != nil && !(permission?.enabled!)! {
            print("Changing to Enable")
            button.setTitle("Enable", for: .normal)
        } else {
            print("permission.enabled == nil")
        }
    }
}
