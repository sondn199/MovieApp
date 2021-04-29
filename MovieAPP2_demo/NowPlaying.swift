//
//  NowPlaying.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 18/04/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nowPlaying = try? newJSONDecoder().decode(NowPlaying.self, from: jsonData)

import Foundation

// MARK: - NowPlaying
struct NowPlaying: Codable {
    let dates: Dates
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
    case ru = "ru"
}
