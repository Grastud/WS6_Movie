//
//  MoviesViewController.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 21.04.19 with the help of tutorial by Harley Trung:
//  https://www.youtube.com/watch?v=F0fLmK96TXk
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/CreateATableView.html#//apple_ref/doc/uid/TP40015214-CH8-SW1
    
    var movies: [NSDictionary]?
    // selectedMovie: StoredMovie?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        fetchMovies()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Markovy
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // tableView(_:cellForRowAt:), configures and provides a cell to display for a given row. Each row in a table
        // view has one cell, and that cell determines the content that appears in that row and how that content is
        // laid out.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row] // obtain appropriate movie from movies array
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
//        let posterPath = movie["poster_path"] as! String
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
       
        let baseUrl = "http://image.tmdb.org/t/p/w500"

        if let posterPath = movie["poster_path"] as? String{
            let posterUrl = NSURL(string: baseUrl + posterPath)
            cell.posterView.setImageWith(posterUrl! as URL)
            
            // passing poster to Details
           // let viewController = MovieDetailViewController(nibName: "DetailMovieViewController", bundle: nil)
           // viewController.posterImageView = posterView
           // navigationController?.pushViewController(viewController, animated: true)
            
        }
        
        // print("row \(indexPath.row)")
        return cell
    }
    
    /*
    https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/ManageSelections/ManageSelections.html#//apple_ref/doc/uid/TP40007451-CH9
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {    }
    */
    
    func fetchMovies() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            url: url! as URL,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue:OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest,
            completionHandler: { (dataOrNil, response, error) in
                                                                        
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                print("response: \(responseDictionary)")
                        self.movies = (responseDictionary["results"] as! [NSDictionary]) // fill movies array
                        self.tableView.reloadData()
                }
            }
        })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        guard let movieDetailViewController = segue.destination as? MovieDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row
            else { return }
        
        movieDetailViewController.movie = movies![row] // pass the selected movie to the MovieDetailViewController
    }
    
}
