//
//  LocalMovie.swift
//  WS6_Movie
//
//  Created by Student on 27.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation
import RealmSwift

class Favorite: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title:String = ""
    override static func primaryKey() -> String {
        return "id"
    }
    
    
}
