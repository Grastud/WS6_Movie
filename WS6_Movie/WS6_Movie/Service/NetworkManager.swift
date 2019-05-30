//
//  NetworkManager.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 14.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation
import Moya

protocol Network {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

struct NetworkManager: Network {
    
    static let MovieAPIKey = "182e1645db53928b72d380dcb4d2c2f2"  // associated with: https://www.themoviedb.org/u/grastud
    
    let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: false)])
    
    func getNewMovies(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.newMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResult.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getUpcomingMovies(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.upcoming(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResult.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                    
                    // exception raised in MovieResult \ int() \ movies = try container.decode([Movie].self, forKey: .movies)
                    print("Upcoming: page: \(page)")
                    print(response.data)
                }
            case let .failure(error):
                print(error)
            }
        }
    }    
    
    func getPopularMovies(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.popular(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResult.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                    
                    // exception raised in MovieResult \ int() \ movies = try container.decode([Movie].self, forKey: .movies)
                    print("Popular: page: \(page)")
                    print(response.data)                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getSearchedMovies(page: Int, query: String, completion: @escaping ([Movie])->()){
        provider.request(.searched(page: page, query: query)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResult.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                    print("Searched: page: \(page)")
                    print(response.data)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
