//
//  SurveyTableViewCell.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 9/7/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var completedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
