//
//  Tool.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 18/05/2021.
//

import Foundation
class Tools {
    static func SaveObjectUserDefault(_ object : Any? , key : String){
        let defaults = UserDefaults.standard
        defaults.setValue(object, forKey: key)
        defaults.synchronize()
    }
    static func GetObjectUserDefault(key : String) -> Any?{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key)
    }
}
