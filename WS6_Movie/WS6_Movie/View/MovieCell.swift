//
//  MovieCell.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 15.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//


import UIKit


class MovieCell: UITableViewCell {
    
    static let nibName = String(describing: MovieCell.self)
    static let reuseIdentifier = String(describing: MovieCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
}
