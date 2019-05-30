//
//  ActorCell.swift
//  WS6_Movie
//
//  Created by Alina on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class ActorCell: UITableViewCell {

    static let nibName = String(describing: ActorCell.self)
    static let reuseIdentifier = String(describing: ActorCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!

}
