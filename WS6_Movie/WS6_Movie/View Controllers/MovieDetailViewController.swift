//
//  MovieDetailViewController.swift
//  WS6_Movie
//
//  Created by asya on 08.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    /*
     To pass 'data' (= a movie) from the MoviesViewController to the MovieDetailViewController
     when a row is selected in the table view using prepare(), the destination controller needs to declare
     a public stored property (= a movie) to hold the data.
     In MoviesViewController: array of movies, i.e. array of NSDictionary
     In MovieDetailViewController: a single movie, i.e. a NSDictionary; since it can only receive data
     after initialization, the movie property must be optional
    */
    
    var movie: Movie?

    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var backdropView: UIImageView! {
        didSet {
            guard let poster = backdropView.image
                else { return }
            
            DispatchQueue.main.async {
                let aspectRatio = poster.size.height / poster.size.width
                self.posterHeight.constant = aspectRatio * UIScreen.main.bounds.width
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
        descriptionLabel.text = movie?.overview
        
        backdropView.kf.setImage(with: movie?.fullBackdropURL)
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
