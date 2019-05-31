//
//  MoviesViewController.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 21.04.19 
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit
import Kingfisher


class MoviesViewController: UIViewController {
    private let provider = NetworkManager()
    var movies = [Movie]()
    
    @IBOutlet weak var listSwitcher: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MovieCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: MovieCell.reuseIdentifier)
        
        loadNewMovies()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard
            let movieDetailViewController = segue.destination as? MovieDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row
            else {
                return
            }
        
        movieDetailViewController.id = movies[row].id
    }
    
    @IBAction func listSwitcherChanged(_ sender: Any) {
        movies.removeAll()
        tableView.reloadData()
        
        if listSwitcher.selectedSegmentIndex == 0 {
            loadNewMovies()
        }
        else {
            loadUpcomingMovies()
        }
    }
    
    private func loadNewMovies(){
        provider.getNewMovies(page: 1) {[weak self] movies in
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
    
    private func loadUpcomingMovies(){
        provider.getUpcomingMovies(page: 1) {[weak self] movies in
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
    
    private func loadPopularNewMovies(){  // JSON decoding error
        provider.getPopularMovies(page: 1) {[weak self] movies in
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
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
        
        performSegue(withIdentifier: "fromMoviesToMovie", sender: self)
    }
    
}
