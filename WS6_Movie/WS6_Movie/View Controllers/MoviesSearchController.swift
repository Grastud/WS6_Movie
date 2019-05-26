//
//  MoviesSearchController.swift
//  WS6_Movie
//
//  Created by Alina on 18.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class MoviesSearchController: UIViewController {
    private let provider = NetworkManager()
    var movies = [Movie]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MovieCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: MovieCell.reuseIdentifier)

        loadNewMovies()
    }
    
    private func loadNewMovies(){
        provider.getNewMovies(page: 1) {[weak self] movies in
            print("\(movies.count) new movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
    
}

extension MoviesSearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.posterImageView.kf.setImage(with: movie.fullPosterURL)
        
        return cell
    }
}
