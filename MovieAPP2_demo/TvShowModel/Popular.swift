//
//  Popular.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/06/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tvAirToday = try? newJSONDecoder().decode(TvAirToday.self, from: jsonData)

import Foundation

// MARK: - TvAirToday
struct TvPopular: Codable {
    let page: Int
    let results: [Result_Tvpopular]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result_Tvpopular: Codable {
    let backdropPath, firstAirDate: String
    let genreIDS: [Int]
    let id: Int
    let name: String
    let originCountry: [OriginCountry]
    let originalLanguage: OriginalLanguage_Tvpopular
    let originalName, overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginCountry: String, Codable {
    case co = "CO"
    case mx = "MX"
    case no = "NO"
    case us = "US"
}

enum OriginalLanguage_Tvpopular: String, Codable {
    case en = "en"
    case es = "es"
    case no = "no"
}

