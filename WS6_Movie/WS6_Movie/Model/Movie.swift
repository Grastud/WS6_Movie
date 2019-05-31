//
//  Movie.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 14.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let posterPath: String
    let title: String
    let overview: String
    
    var fullPosterURL:URL?{
        get{
            if(posterPath.isEmpty) {
                return nil
            } else {
                return URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
            }
        }
    }
}

extension Movie: Decodable {
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
    }
}

