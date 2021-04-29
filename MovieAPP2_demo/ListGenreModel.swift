//
//  ListGenreModel.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 27/04/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let listGenre = try? newJSONDecoder().decode(ListGenre.self, from: jsonData)

import Foundation

// MARK: - ListGenre
struct ListGenre: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

