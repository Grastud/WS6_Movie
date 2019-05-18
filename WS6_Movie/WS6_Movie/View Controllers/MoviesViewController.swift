//
//  MoviesViewController.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 21.04.19 
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit
import Kingfisher


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
        tableView.delegate = self
        tableView.register(UINib(nibName: MovieCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: MovieCell.reuseIdentifier)
        //
        loadNewMovies()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare() should get called by when user clicks on a movie cell
        // and segue from segue.source (= self) to segue.destination (= MovieDetailViewController)
        //
        // for some reason, prepare() is never called - possibly the segue is improperly
        // set in the IB, or there is some unintended interaction with the switcher
        //
        // fix: see tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        // that programmatically triggers the segue
        
        NSLog("prepare(): IN")
        
        super.prepare(for: segue, sender: sender)
        
        guard
            let movieDetailViewController = segue.destination as? MovieDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row
            else {
                NSLog("prepare(): segue identifier  %@", segue.identifier ?? "missing")
                NSLog("prepare(): segue source      %@", segue.source.nibName ?? "missing")
                NSLog("prepare(): segue destination %@", segue.destination.nibName ?? "missing")
                return }
        
        NSLog("prepare(): row = %d title = %@:", row, movies[row].title)
        
        movieDetailViewController.movie = movies[row] // pass the selected movie to the MovieDetailViewController
        
        NSLog("prepare(): OUT")
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
        NSLog("tableView() didSelectRowAt: IN")
        
        let row = indexPath.row
        NSLog("tableView() didSelectRowAt: row = %d", row)
        
        // programmatically perform the segue; see prepare()
        //
        // https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performSegueWithIdentifier
        // Normally, segues are initiated automatically and not using this method. However, you can use this method in cases where the segue could not be configured in your storyboard file. For example, you might call it from a custom action handler used in response to shake or accelerometer events.
        
        // let movieDetailViewController = segue.destination as? MovieDetailViewController,
        // movieDetailViewController.movie = movies[row] // pass the selected movie to the MovieDetailViewController
        
        NSLog("tableView() didSelectRowAt: -> performSegue() -> prepare()")
        performSegue(withIdentifier: "fromMoviesToMovie", sender: self) // -> prepare()
        // tableView.deselectRow(at: indexPath, animated: true)
        
        NSLog("tableView() didSelectRowAt: OUT")
    }
}
