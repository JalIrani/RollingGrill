//
//  DrinkTableViewCell.swift
//  RollingGrill
//
//  Created by Jal Irani on 9/29/17.
//  Copyright © 2017 Apptzr. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkItemLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!
    @IBOutlet weak var drinkDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
