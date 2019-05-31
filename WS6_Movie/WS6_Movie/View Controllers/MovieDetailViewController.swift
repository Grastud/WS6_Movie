//
//  MovieDetailViewController.swift
//  WS6_Movie
//
//  Created by asya on 08.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let provider = NetworkManager()
    
    var id: Int?
    var movieDetails: MovieDetails?
    let realm = RealmApi()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var fav_star: UIButton!
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
        
        loadMovieDetails()
        
        titleLabel.sizeToFit()
        taglineLabel.sizeToFit()
        descriptionLabel.sizeToFit()
    }
    
    private func updateTexts() {
        titleLabel.text = movieDetails?.title
        taglineLabel.text = movieDetails?.tagline
        releaseDateLabel.text = movieDetails?.releaseDate
        descriptionLabel.text = movieDetails?.overview
        backdropView.kf.setImage(with: movieDetails?.fullBackdropURL, placeholder: UIImage(named:"default_backdrop"))
        updateFavoriteLabel()
    }
    
    private func loadMovieDetails(){
        provider.getMovie(id: id ?? 0) {[weak self] (movie: MovieDetails) in
            self?.movieDetails = movie
            self?.updateTexts()
        }
    }
    
    @IBAction func tapOnButton(_ sender: Any) {
        if (realm.isFavoriteMovie(id: movieDetails?.id ?? 0)){
            realm.removeFavoriteMovie(id: movieDetails?.id ?? 0)
        } else {
            realm.addFavoriteMovie(id: movieDetails?.id ?? 0, movieTitle: movieDetails?.title ?? "", tagline: movieDetails?.tagline ?? "")
        }
        
        updateFavoriteLabel()
    }
    
    func updateFavoriteLabel(){
        if (realm.isFavoriteMovie(id: movieDetails?.id ?? 0)){
            fav_star.setImage(UIImage(named: "star_filled"), for: UIControl.State.normal)
        }
        else {
            fav_star.setImage(UIImage(named: "star_empty"), for: UIControl.State.normal)
        }
    }
}
