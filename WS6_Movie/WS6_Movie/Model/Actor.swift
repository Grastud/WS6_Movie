//
//  Actor.swift
//  WS6_Movie
//
//  Created by Alina on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation

struct Actor{
    let id: Int
    let name: String
    let profilePath: String
    
    var fullProfileURL:URL?{
        get{
            if(profilePath.isEmpty) {
                return nil
            } else {
                return URL(string: "https://image.tmdb.org/t/p/w500" + profilePath)
            }
        }
    }
}

extension Actor: Decodable {
    enum ActorCodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActorCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        profilePath = try container.decode(String.self, forKey: .profilePath)
    }
}

