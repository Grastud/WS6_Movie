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
    private var movies = [Movie]()
    

    @IBOutlet weak var listSwitcher: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadNewMovies()
    }
    
    
    @IBAction func listSwitcherChanged(_ sender: Any) {
        movies.removeAll()
        tableView.reloadData()
        if listSwitcher.selectedSegmentIndex == 0{
            loadNewMovies()
        }
        else if listSwitcher.selectedSegmentIndex == 1{
            loadPopularNewMovies()
        } else {
            loadMoviesWithBradPitt()
        }
    }
    
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.register(UINib(nibName: MovieCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func loadNewMovies(){
        
        provider.getNewMovies(page: 1) {[weak self] movies in
            print("\(movies.count) new movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
    
    private func loadPopularNewMovies(){
        
        provider.getPopularMovies(page: 1) {[weak self] movies in
            print("\(movies.count) popular movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
    
    private func loadMoviesWithBradPitt() {
        provider.getMoviesWithActors(actorIds: [819]) {[weak self] movies in
            print("\(movies.count) popular movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.tableView.reloadData()
        }
    }
}

extension MoviesViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell{
            cell.titleLabel.text = movie.title
            cell.overviewLabel.text = movie.overview
            if let url = movie.fullPosterURL{
                cell.posterImageView.kf.setImage(with: url)
            }
            
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath)
    }
    
    
    
}

