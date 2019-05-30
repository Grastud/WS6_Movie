//
//  ActorDetailedResult.swift
//  WS6_Movie
//
//  Created by Alina on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation

struct ActorDetails{
    let id: Int
    let name: String
    let biography: String
    let profilePath: String
    
    var fullProfileURL:URL?{
        get{
            if(profilePath.isEmpty) {
                return nil
            } else {
                return URL(string: "https://image.tmdb.org/t/p/w780" + profilePath)
            }
        }
    }
}

extension ActorDetails: Decodable {
    enum ActorDetailsCodingKeys: String, CodingKey {
        case id
        case name
        case biography
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActorDetailsCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        NSLog("id: \(id)")
        name = try container.decode(String.self, forKey: .name)
        NSLog("name: \(name)")
        biography = try container.decode(String.self, forKey: .biography)
        NSLog("biography: \(biography)")
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath) ?? ""
    }
}

