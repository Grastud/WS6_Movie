//
//  ActorDetailController.swift
//  WS6_Movie
//
//  Created by Alina on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class ActorDetailViewController: UIViewController {
    private let provider = NetworkManager()
    
    var id: Int?
    var actorDetails: ActorDetails?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var biographyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadActor()
        
        updateTexts()
        biographyLabel.sizeToFit()
        
    }
    
    private func updateTexts(){
        nameLabel.text = actorDetails?.name
        biographyLabel.text = actorDetails?.biography
        profileImage.kf.setImage(with: actorDetails?.fullProfileURL, placeholder: UIImage(named:"default_backdrop"))
    }
    
    private func loadActor(){
        provider.getActor(id: id ?? 0) {[weak self] (actoring: ActorDetails) in
            self?.actorDetails = actoring
            self?.updateTexts()
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
    
}

