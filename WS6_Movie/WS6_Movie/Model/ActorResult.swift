//
//  ActorResult.swift
//  WS6_Movie
//
//  Created by Alina on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation

struct ActorResult {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let actors: [Actor]
}

extension ActorResult: Decodable {
    
    private enum ActorResultCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case actors = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActorResultCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        NSLog("page: \(page)")
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        NSLog("total_results: \(numberOfResults)")
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        NSLog("total_pages: \(numberOfPages)")
        actors = try container.decode([Actor].self, forKey: .actors)
        NSLog("results: %d", actors.count)
    }
}
