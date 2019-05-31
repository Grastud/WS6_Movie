//
//  RealmApi.swift
//  WS6_Movie
//
//  Created by Student on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation
import RealmSwift

class RealmApi{
    
    let realm = try! Realm()
    
    func isFavoriteMovie(id: Int) -> Bool {
        return nil != realm.object(ofType: FavoriteMovie.self, forPrimaryKey: id)
    }
    
    func findFavoriteMovie(id: Int) -> FavoriteMovie {
        return realm.object(ofType: FavoriteMovie.self, forPrimaryKey: id)!
    }
    
    func addFavoriteMovie(id: Int, movieTitle: String, tagline: String) {
        if (!isFavoriteMovie(id: id)) {
            let favoriteMovie = FavoriteMovie()
            favoriteMovie.title = movieTitle
            favoriteMovie.id = id
            favoriteMovie.tagline = tagline
            try! realm.write(){
                realm.add(favoriteMovie)
            }
        }
    }
    
    func removeFavoriteMovie (id: Int) {
        if (isFavoriteMovie(id: id)) {
            let toDelete = findFavoriteMovie(id: id)
            try! realm.write() {
                realm.delete(toDelete)
            }
        }
    }
}
    

