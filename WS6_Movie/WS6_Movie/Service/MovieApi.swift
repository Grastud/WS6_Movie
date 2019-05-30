//
//  MovieApi.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 14.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case newMovies(page: Int)
    case upcoming(page: Int)
    case popular(page: Int)
    case recommended(id: Int)
    case actor(ids: [Int])
    case searched(page: Int, query: String)
}

// https://www.themoviedb.org/documentation/api
// https://developers.themoviedb.org/3/discover/movie-discover

extension MovieApi: TargetType { //
    
    var baseURL: URL {
        let tmdbApi = "https://api.themoviedb.org/3" // for V4: "https://api.themoviedb.org/4"; requires changes to the API and network services
                
        guard let url = URL(string: tmdbApi) else {
            fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .newMovies:
            return "movie/now_playing" // https://developers.themoviedb.org/3/movies/get-now-playing
        case .upcoming:
            return "movie/upcoming" // https://developers.themoviedb.org/3/movies/get-upcoming
        case .popular:
            return "movie/popular" // https://developers.themoviedb.org/3/movies/get-popular-movies
        case .recommended(let id):
            return "movie/\(id)/recommendations"
        case .actor:
            return "discover/movie"
        case .searched:
            return "search/movie" // https://developers.themoviedb.org/3/search/search-movies
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .newMovies(let page), .upcoming(let page), .popular(let page):
            return .requestParameters(parameters: ["page":page, "api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .recommended:
            return .requestParameters(parameters: ["api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .actor(let ids):
            let params = ids.map({"\($0)"}).joined(separator: ",")
            return .requestParameters(parameters: ["api_key": NetworkManager.MovieAPIKey, "with_people": params], encoding: URLEncoding.queryString)
        case .searched(let page, let query):
            return .requestParameters(parameters: ["page": page, "api_key": NetworkManager.MovieAPIKey, "query": query], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
