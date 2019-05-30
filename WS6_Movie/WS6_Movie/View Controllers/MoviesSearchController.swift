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
    var searchedMovies = [Movie]()
    var searching = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self
        
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
    
    func loadSearchedMovies(query: String){
        provider.getSearchedMovies(page: 1, query: query) {[weak self] movies in
            self?.searchedMovies.removeAll()
            self?.searchedMovies.append(contentsOf: movies)
            print("\(movies.count) searched movies loaded")
            self?.tableView.reloadData()
        }
    }
}

extension MoviesSearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching) {
            return searchedMovies.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        var movie = movies[indexPath.row]
        if(searching) {
            movie = searchedMovies[indexPath.row]
        }

        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.posterImageView.kf.setImage(with: movie.fullPosterURL)
        
        return cell
    }
}

extension MoviesSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = !searchText.isEmpty
        if(searching) {
            loadSearchedMovies(query: searchText)
        }
        tableView.reloadData()
    }
    
}
