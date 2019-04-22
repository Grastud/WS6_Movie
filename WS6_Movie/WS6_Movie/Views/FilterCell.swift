//
//  FilterCell.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 22.04.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    var flag = true
    @IBAction func onSwitchAction(_ sender: UISwitch) {
        flag = !flag
    }
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var onOffSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
