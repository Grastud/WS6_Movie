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
    
    static let MovieAPIKey = "182e1645db53928b72d380dcb4d2c2f2"
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
    
    func getPopularMovies(page: Int, completion: @escaping ([Movie])->()){
        
        provider.request(.popular(page: 1)) { result in
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
    
    func getMoviesWithActors(actorIds: [Int], completion: @escaping ([Movie]) -> ()) {
        
        provider.request(.actor(ids: actorIds)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(MovieResult.self, from: response.data)
                    completion(result.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
