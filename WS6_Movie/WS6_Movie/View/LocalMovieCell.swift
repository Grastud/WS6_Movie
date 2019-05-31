//
//  LocalMovieCell.swift
//  WS6_Movie
//
//  Created by Student on 31.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class LocalMovieCell: UITableViewCell {
    static let nibName = String(describing: LocalMovieCell.self)
    static let reuseIdentifier = String(describing: LocalMovieCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
}
