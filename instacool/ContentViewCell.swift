//
//  ContentViewCell.swift
//  instacool
//
//  Created by Bishal Gautam on 2/21/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//

import UIKit

class ContentViewCell: UITableViewCell {

    @IBOutlet weak var myCaptionLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
