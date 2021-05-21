//
//  SearchMovieByTitle.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 18/05/2021.
//

//
//  Model.swift
//  asd
//
//  Created by ngoc son on 18/05/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchMovieByTitle = try? newJSONDecoder().decode(SearchMovieByTitle.self, from: jsonData)

import Foundation

// MARK: - SearchMovieByTitle
struct SearchMovieByTitle: Codable {
    let page: Int
    let results: [Result2]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result2: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//enum OriginalLanguage1: String, Codable {
//    case en = "en"
//}


