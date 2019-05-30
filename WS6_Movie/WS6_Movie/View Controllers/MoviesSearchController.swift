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
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
    
    func loadSearchedMovies(query: String){
        provider.getSearchedMovies(page: 1, query: query) {[weak self] movies in
            self?.searchedMovies.removeAll()
            self?.searchedMovies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard
            let movieDetailViewController = segue.destination as? MovieDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row
            else {
                return
            }
        
        if(searching) {
            movieDetailViewController.movie = searchedMovies[row]
        } else {
            movieDetailViewController.movie = movies[row]
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
        cell.posterImageView.kf.setImage(with: movie.fullPosterURL, placeholder: UIImage(named:"default_poster"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // programmatically perform the segue; see prepare()
        //
        // https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performSegueWithIdentifier
        // Normally, segues are initiated automatically and not using this method. However, you can use this method in cases where the segue could not be configured in your storyboard file. For example, you might call it from a custom action handler used in response to shake or accelerometer events.
        
        performSegue(withIdentifier: "fromSearchToMovie", sender: self) // -> prepare()
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
