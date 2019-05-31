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
    @IBOutlet weak var knownForLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadActor()

        biographyLabel.sizeToFit()
    }
    
    private func updateTexts(){
        nameLabel.text = actorDetails?.name
        knownForLabel.text = actorDetails?.knownForDepartment
        birthdayLabel.text = actorDetails?.birthday
        placeOfBirthLabel.text = actorDetails?.placeOfBirth
        biographyLabel.text = actorDetails?.biography
        profileImage.kf.setImage(with: actorDetails?.fullProfileURL, placeholder: UIImage(named:"default_backdrop"))
    }
    
    private func loadActor(){
        provider.getActor(id: id ?? 0) {[weak self] (actor: ActorDetails) in
            self?.actorDetails = actor
            self?.updateTexts()
        }
    }
}

