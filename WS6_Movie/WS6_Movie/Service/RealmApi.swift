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
    
    func addFavorites (fav: Favorite){
        let realm = try! Realm()
        let fav = Favorite()
        try! realm.write(){
            realm.add(fav)
        }
    }

func removeFavorites (fav: Favorite){
    let realm = try! Realm()
    let fav = Favorite()
    try! realm.write(){
        realm.delete(fav)
    }
}

    func currentFavorite (fav: Favorite) -> Favorite{
        let realm = try! Realm()
            if let fav = realm.objects(Favorite.self).first{
                return currentFavorite(fav: fav)
        }
            else{
            //if no favorite was found -> add one
                addFavorites(fav: fav)
        }
    return fav
    }
var favorites:Results<Favorite>? {
    get {
        guard let realm = try? Realm() else {
            return nil
        }
        return realm.objects(Favorite.self)
    }
}
    
}
