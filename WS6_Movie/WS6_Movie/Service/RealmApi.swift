//
//  RealmApi.swift
//  WS6_Movie
//
//  Created by Student on 30.05.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import Foundation
import RealmSwift

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

var favorites:Results<Favorite>? {
    get {
        guard let realm = try? Realm() else {
            return nil
        }
        return realm.objects(Favorite.self)
    }
}
