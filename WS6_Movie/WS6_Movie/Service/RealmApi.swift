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
    
    func isFavorite(id: Int) -> Bool {
        return nil != realm.object(ofType: Favorite.self, forPrimaryKey: id)
    }
    
    func findFavorite(id: Int) -> Favorite {
        return realm.object(ofType: Favorite.self, forPrimaryKey: id)!
    }
    
    func addFavorites (id: Int, movieTitle: String){
        if (!isFavorite(id: id)) {
            let fav = Favorite()
            fav.title = movieTitle
            fav.id = id
            try! realm.write(){
                realm.add(fav)
            }
        }
    }
    
    func removeFavorites (id: Int){
        if (isFavorite(id: id)) {
            let toDelete = findFavorite(id: id)
            try! realm.write(){
                realm.delete(toDelete)
            }
        }
    }
}
    

