//
//  MovieCell.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 21.04.19 with the help of tutorial by Harley Trung:
//  https://www.youtube.com/watch?v=F0fLmK96TXk
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var posterView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
