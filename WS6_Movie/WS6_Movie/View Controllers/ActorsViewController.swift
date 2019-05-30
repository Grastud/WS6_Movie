//
//  ActorsViewController.swift
//  WS6_Movie
//
//  Created by Alina on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit
import Kingfisher


class ActorsViewController: UIViewController {
    private let provider = NetworkManager()
    var actors = [Actor]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ActorCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: ActorCell.reuseIdentifier)
        
        loadPopularActors()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard
            let actorDetailViewController = segue.destination as? ActorDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        
        actorDetailViewController.id = actors[row].id
    }
    
    private func loadPopularActors(){
        provider.getPopularActors(page: 1) {[weak self] actors in
            self?.actors.removeAll()
            self?.actors.append(contentsOf: actors)
            self?.tableView.reloadData()
        }
    }
    
}

extension ActorsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActorCell.reuseIdentifier, for: indexPath) as! ActorCell
        
        let actor = actors[indexPath.row]
        cell.titleLabel.text = actor.name
        cell.profileImage.kf.setImage(with: actor.fullProfileURL, placeholder: UIImage(named:"default_poster"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // programmatically perform the segue; see prepare()
        //
        // https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performSegueWithIdentifier
        // Normally, segues are initiated automatically and not using this method. However, you can use this method in cases where the segue could not be configured in your storyboard file. For example, you might call it from a custom action handler used in response to shake or accelerometer events.
        
        performSegue(withIdentifier: "fromActorsToActor", sender: self)
    }
}
