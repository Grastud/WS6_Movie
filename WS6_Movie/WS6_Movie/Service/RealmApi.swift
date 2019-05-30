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
    //Damit man die View von Bookmarks füllen kann, die Favoriten nur anzeigen
var favorites:Results<Favorite>? {
    get {
        guard let realm = try? Realm() else {
            return nil
        }
        return realm.objects(Favorite.self)
    }
}
    //Ob die Filme in der Liste des Favoriten sind
    func findFavorite(title:String)->Favorite? {
        guard let realm = try? Realm() else {
            return nil
        }
        let fav = realm.object(ofType: Favorite.self, forPrimaryKey: title)
        return fav
    }
    //Ob die Filme schon favorisiert sind??
    /*func isFavorited(movie: Movie) -> Bool{
        let realm = try! Realm()
        let fav = realm.object(ofType: Favorite.self, forPrimaryKey: movie.title)
        if (favorites.contains(fav)){
            return true
        }
        else {
            return false
        }
        
        
    }*/
    
    
}
