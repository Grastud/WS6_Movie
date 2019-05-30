//
//  MovieResult.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 14.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation

struct MovieResult {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieResult: Decodable {
    
    private enum MovieResultCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieResultCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        NSLog("page: \(page)")
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        NSLog("total_results: \(numberOfResults)")
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        NSLog("total_pages: \(numberOfPages)")
        movies = try container.decode([Movie].self, forKey: .movies)
        NSLog("results: %d", movies.count)
    }
}

