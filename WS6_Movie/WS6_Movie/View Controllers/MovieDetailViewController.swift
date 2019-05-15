//
//  MovieDetailViewController.swift
//  WS6_Movie
//
//  Created by asya on 08.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

/*import UIKit

class MovieDetailViewController: UIViewController {
    
    /*
     To pass 'data' (= a movie) from the MoviesViewController to the MovieDetailViewController
     when a row is selected in the table view using prepare(), the destination controller needs to declare
     a public stored property (= a movie) to hold the data.
     In MoviesViewController: array of movies, i.e. array of NSDictionary
     In MovieDetailViewController: a single movie, i.e. a NSDictionary; since it can only receive data
     after initialization, the movie property must be optional
    */
    
    var movie: NSDictionary?

    
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet private weak var posterHeight: NSLayoutConstraint!
    
    // var newImage: UIImage!
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            guard let poster = posterImageView.image
                else { return }
            
            DispatchQueue.main.async {
                let aspectRatio = poster.size.height / poster.size.width
                self.posterHeight.constant = aspectRatio * UIScreen.main.bounds.width
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // posterImageView.image = newImage

        // Do any additional setup after loading the view.
        
        /*
         e.g. https://matteomanferdini.com/how-ios-view-controllers-communicate-with-each-other/
         imageView?.image = contact?.photo
         nameLabel?.text = contact?.name
         positionLabel?.text = contact?.position
         emailButton?.setTitle(contact?.email, for: .normal)
         phoneButton?.setTitle(contact?.phone, for: .normal)
         */
        
        //        let posterPath = movie["poster_path"] as! String

        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie!["poster_path"] as? String {
            let posterUrl = NSURL(string: baseUrl + posterPath)
            
            posterImageView.setImageWith(posterUrl! as URL)
            titleLabel.text = movie!["title"] as? String // let title = movie?["title"] as! String
            categoryLabel.text = movie!["release_date"] as? String // movie?["overview"] as! String
        }
        
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /* unwind segue?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
    }
 */
    
}*/
