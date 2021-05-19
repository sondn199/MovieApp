//
//  CastImage.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 19/05/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let person = try? newJSONDecoder().decode(Person.self, from: jsonData)

import Foundation

// MARK: - Person
struct CastImages: Codable {
    let id: Int
    let profiles: [Profile]
}

// MARK: - Profile
struct Profile: Codable {
    let aspectRatio: Double
    let filePath: String
    let height: Int
    let iso639_1: JSONNull?
    let voteAverage: Double
    let voteCount, width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso639_1 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

// MARK: - Encode/decode helpers

