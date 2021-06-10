//
//  File.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 02/06/2021.
//

import Foundation
import RealmSwift

class FavoriteHelper {
    
     static let shared = FavoriteHelper()
    let realm:Realm?
    
    init() {
        realm = try? Realm()
    }
    
    func getAllFavoriteMovie() -> [FavoriteModel]? {
        if let results = realm?.objects(FavoriteModel.self).toArray(ofType: FavoriteModel.self) {
            return results
        }
        return nil
    }
    
    func deleteFavoriteMovie(idMovie: Int) {
        if let reults = getFavoriteMovie(idMovie: idMovie) {
            do {
                try realm?.write({
                    realm?.delete(reults)
                })
            } catch {
                
            }
        }
    }
    
    func getFavoriteMovie(idMovie: Int) -> FavoriteModel? {
        if let results = realm?.objects(FavoriteModel.self).filter("idMovie = %@", idMovie).toArray(ofType: FavoriteModel.self) {
            if !(results.isEmpty) {
                return results[0]
            }
        }
        return nil
        
    }
    
    func addFavoriteMovie(idMovie: Int) {
        let favoriteModel = FavoriteModel()
        favoriteModel.id = UUID().uuidString
        favoriteModel.idMovie = idMovie
        
        do {
            try! realm?.write({
                realm?.add(favoriteModel)
            })
        } catch {
            print(error)
        }

    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
