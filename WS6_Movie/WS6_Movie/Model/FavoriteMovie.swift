//
//  LocalMovie.swift
//  WS6_Movie
//
//  Created by Student on 27.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteMovie: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var tagline = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}
