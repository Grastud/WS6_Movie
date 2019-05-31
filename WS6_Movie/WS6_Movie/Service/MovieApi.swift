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
    case upcomingMovies(page: Int)
    case popularMovies(page: Int)
    case recommended(id: Int)
    case actor(id: Int)
    case searched(page: Int, query: String)
    case popularActors(page: Int)
    case movie(id: Int)
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
        case .upcomingMovies:
            return "movie/upcoming" // https://developers.themoviedb.org/3/movies/get-upcoming
        case .popularMovies:
            return "movie/popular" // https://developers.themoviedb.org/3/movies/get-popular-movies
        case .recommended(let id):
            return "movie/\(id)/recommendations"
        case .actor(let id):
            return "/person/\(id)"
        case .searched:
            return "search/movie" // https://developers.themoviedb.org/3/search/search-movies
        case .popularActors:
            return "/person/popular"
        case .movie(let id):
            return "/movie/\(id)"
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
        case .newMovies(let page), .upcomingMovies(let page), .popularMovies(let page), .popularActors(let page):
            return .requestParameters(parameters: ["page":page, "api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .recommended:
            return .requestParameters(parameters: ["api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .searched(let page, let query):
            return .requestParameters(parameters: ["page": page, "api_key": NetworkManager.MovieAPIKey, "query": query], encoding: URLEncoding.queryString)
        case .actor(let id):
            return .requestParameters(parameters: ["person_id": id, "api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .movie(let id):
            return .requestParameters(parameters: ["movie_id": id, "api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
