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
    
    func addFavorites (movieTitle:String){
       
        let fav = Favorite()
        fav.title=movieTitle
        try! realm.write(){
            realm.add(fav)
        }
    }

    func removeFavorites (movieTitle:String){
        let toDelete = findFavorite(movieTitle: movieTitle)
        if (toDelete?.title==movieTitle) {
            try! realm.write(){
                realm.delete(toDelete!)
            }
        }
}

    /*func isFavorite (movieTitle:String) -> Bool {
       
        
            //if (realm.objects(Favorite.self).contains(fav)){
                return true
        }
            else{
            
                return false
        }
        }*/
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
    func findFavorite(movieTitle:String)->Favorite? {
        let fav = realm.object(ofType: Favorite.self, forPrimaryKey: movieTitle)
            if (fav?.title==movieTitle) {
                return fav
            }
        return nil
    }
    
    
    
    
}
