//
//  FavoriteModel.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 02/06/2021.
//

import Foundation
import RealmSwift


class FavoriteModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var idMovie: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
}
