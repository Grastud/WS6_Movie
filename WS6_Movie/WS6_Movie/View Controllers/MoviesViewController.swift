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
    var newMovies = [Movie]()
    var upcomingMovies = [Movie]()
    
    let indexNew = 0
    let indexUpcoming = 1
    
    var currentPageUpcoming = 1
    var totalPagesUpcoming = 1
    var currentPageNew = 1
    var totalPagesNew = 1
    
    @IBOutlet weak var listSwitcher: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MovieCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: MovieCell.reuseIdentifier)
        
        loadNewMovies()
        loadUpcomingMovies()
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
        if (listSwitcher.selectedSegmentIndex == indexNew) {
            movieDetailViewController.id = newMovies[row].id
        } else {
            movieDetailViewController.id = upcomingMovies[row].id
        }
        
    }
    
    @IBAction func listSwitcherChanged(_ sender: Any) {
        newMovies.removeAll()
        upcomingMovies.removeAll()
        currentPageNew = 1
        currentPageUpcoming = 1
        loadNewMovies()
        loadUpcomingMovies()
        tableView.reloadData()
    }
    
    private func loadNewMovies(){
        provider.getNewMovies(page: currentPageNew) {[weak self] movieResult in
            self?.newMovies.append(contentsOf: movieResult.movies)
            self?.totalPagesNew = movieResult.numberOfPages
            self?.tableView.reloadData()
        }
    }
    
    private func loadUpcomingMovies(){
        provider.getUpcomingMovies(page: currentPageUpcoming) {[weak self] movieResult in
            self?.upcomingMovies.append(contentsOf: movieResult.movies)
            self?.totalPagesUpcoming = movieResult.numberOfPages
            self?.tableView.reloadData()
        }
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (listSwitcher.selectedSegmentIndex == indexNew) {
            return newMovies.count
        } else {
            return upcomingMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        let movie = getMovieOfCell(row: indexPath.row)
        
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.posterImageView.kf.setImage(with: movie.fullPosterURL, placeholder: UIImage(named:"default_poster"))
        
        return cell
    }
    
    private func getMovieOfCell(row: Int) -> Movie {
        if (listSwitcher.selectedSegmentIndex == indexNew) {
            if((row >= newMovies.count - 1) && (currentPageNew < totalPagesNew)) {
                currentPageNew += 1
                loadNewMovies()
            }
            return newMovies[row]
        } else {
            if((row >= upcomingMovies.count - 1) && (currentPageUpcoming < totalPagesUpcoming)) {
                currentPageUpcoming += 1
                loadUpcomingMovies()
            }
            return upcomingMovies[row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // programmatically perform the segue; see prepare()
        //
        // https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performSegueWithIdentifier
        // Normally, segues are initiated automatically and not using this method. However, you can use this method in cases where the segue could not be configured in your storyboard file. For example, you might call it from a custom action handler used in response to shake or accelerometer events.
        
        performSegue(withIdentifier: "fromMoviesToMovie", sender: self)
    }
    
}
