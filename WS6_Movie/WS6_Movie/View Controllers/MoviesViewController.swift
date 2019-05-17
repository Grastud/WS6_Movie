//
//  MoviesViewController.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 21.04.19 
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit
import Kingfisher

// class MoviesViewController: UIViewController {
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let provider = NetworkManager()
    // private var movies = [Movie]()
    var movies = [Movie]()


    @IBOutlet weak var listSwitcher: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tableView.dataSource = self
        tableView.delegate = self // Markovy
        tableView.register(UINib(nibName: MovieCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: MovieCell.reuseIdentifier)
        //
        loadNewMovies()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // override func performSegue(withIdentifier identifier: String, sender: Any?) {
    //    <#code#>
    // }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        NSLog("IN: prepare() %@", "MoviesViewController")
        
        super.prepare(for: segue, sender: sender)
        
        guard
            let movieDetailViewController = segue.destination as? MovieDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row
            else {
                // I should not get here
                // Either destination or source is nil
                // Or, more probable, row is nil!
                NSLog("Segue: identifier %@", segue.identifier ?? "blah")
                NSLog("Segue: source %@", segue.source.nibName ?? "blahblah")
                NSLog("Segue: destination %@", segue.destination.nibName ?? "blahblahblah")
                return }
        
        NSLog("IN: prepare() row = %d title = %@:", row, movies[row].title)
        
        movieDetailViewController.movie = movies[row] // pass the selected movie to the MovieDetailViewController
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("CHECK: tableView() at %@", "TableView")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        NSLog("CHECK: tableView() at %d", row)
        
        // force performSegue
        // https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performSegueWithIdentifier
        // Normally, segues are initiated automatically and not using this method. However, you can use this method in cases where the segue could not be configured in your storyboard file. For example, you might call it from a custom action handler used in response to shake or accelerometer events.
        // performSegue() does not call prepare() ?
        
        // let movieDetailViewController = segue.destination as? MovieDetailViewController,
        // movieDetailViewController.movie = movies[row] // pass the selected movie to the MovieDetailViewController
        
        performSegue(withIdentifier: "fromMoviesToMovie", sender: self)
        NSLog("CHECK: called performSegue() at %d", 143)
        // tableView.deselectRow(at: indexPath, animated: true)
    }
}
