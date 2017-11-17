//
//  ProfileNameTableViewCell.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 9/14/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class ProfileNameTableViewCell: UITableViewCell {
    
    weak var delegate: ProfileNameTableViewCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func leaveStudyButtonPressed(_ sender: UIButton) {
        self.delegate?.leaveStudyButtonPressed()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol ProfileNameTableViewCellDelegate: class {
    func leaveStudyButtonPressed()
}
