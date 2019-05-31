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
    let realm = RealmApi()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var fav_star: UIButton!
    @IBOutlet weak var fav_label: UILabel!
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
        
        titleLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        
        // todo: set text according to whether movie is already favorite or not
        //fav_label.text="favorise"
        updateLabel()
        backdropView.kf.setImage(with: movie?.fullBackdropURL, placeholder: UIImage(named:"default_backdrop"))
    }
    
    @IBAction func tapOnButton(_ sender: Any) {
        
        if (fav_label.text == "favorise"){
            realm.addFavorites(movieTitle: movie?.title ?? "")
            fav_label.text = "unfavorise"
        }
        else {
            realm.removeFavorites(movieTitle: movie?.title ?? "")
            fav_label.text = "favorise"
        }
        
        //updateLabel()
    }
    
    func updateLabel(){
        if (realm.isFavorite(movieTitle: movie?.title ?? "")){
            fav_label.text="unfavorise"
        }
        else {
            fav_label.text="favorise"
        }
    }
}



