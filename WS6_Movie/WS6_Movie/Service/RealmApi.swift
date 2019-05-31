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
    
    func isFavorite(movieTitle: String) -> Bool {
        let favorites = realm.objects(Favorite.self).filter("title = '\(movieTitle)'")
        return favorites.count > 0
    }
    
    
    func findFavorite(movieTitle: String) -> Favorite {
        let fav = realm.objects(Favorite.self).filter("title = '\(movieTitle)'").first
        return fav!
    }
    
    func addFavorites (movieTitle:String){
        if (isFavorite(movieTitle: movieTitle)==false) {
            let fav = Favorite()
            fav.title=movieTitle
            try! realm.write(){
                realm.add(fav)
            }
        }
    }
    
    func removeFavorites (movieTitle:String){
        if (isFavorite(movieTitle: movieTitle)) {
            let toDelete = findFavorite(movieTitle:movieTitle)
            try! realm.write(){
                realm.delete(toDelete)
            }
        }
    }
}
    

