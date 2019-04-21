//
//  MovieCell.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 21.04.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
