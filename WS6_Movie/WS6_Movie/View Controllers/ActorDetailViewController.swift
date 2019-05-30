//
//  ActorDetailController.swift
//  WS6_Movie
//
//  Created by Alina on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class ActorDetailViewController: UIViewController {
    
    /*
     To pass 'data' (= an actor) from the ActorViewController to the ActorDetailViewController
     when a row is selected in the table view using prepare(), the destination controller needs to declare
     a public stored property (= a movie) to hold the data.
     In ActorViewController: array of actors, i.e. array of NSDictionary
     In ActorDetailViewController: a single actor, i.e. a NSDictionary; since it can only receive data
     after initialization, the actor property must be optional
     */
    
    var actor: Actor?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = actor?.name
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

