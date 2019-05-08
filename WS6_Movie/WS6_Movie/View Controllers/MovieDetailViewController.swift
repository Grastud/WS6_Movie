//
//  MovieDetailViewController.swift
//  WS6_Movie
//
//  Created by asya on 08.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    
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
    @IBOutlet private weak var posterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
