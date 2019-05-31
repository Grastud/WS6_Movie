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
    let knownForDepartment: String
    let birthday: String
    let placeOfBirth: String
    
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
        case knownForDepartment = "known_for_department"
        case placeOfBirth = "place_of_birth"
        case birthday
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActorDetailsCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        biography = try container.decode(String.self, forKey: .biography)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath) ?? ""
        knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday) ?? ""
        placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth) ?? ""
    }
}

