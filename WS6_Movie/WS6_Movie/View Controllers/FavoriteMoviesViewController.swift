//
//  FavoriteMoviesViewController.swift
//  WS6_Movie
//
//  Created by Student on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation
import Kingfisher
import RealmSwift

class FavoriteMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let favorites = RealmApi().realm.objects(FavoriteMovie.self)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: LocalMovieCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: LocalMovieCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocalMovieCell.reuseIdentifier, for: indexPath) as! LocalMovieCell
        
        let movie = favorites[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.taglineLabel.text = movie.tagline
        
        return cell
    }
}

