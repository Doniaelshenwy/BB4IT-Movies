//
//  MoviesResponse.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import Foundation

struct MoviesResponse: Codable {
    let results: [MovieResponse]?
}

struct MovieResponse: Codable {
    let id: Int?
    let posterPath: String?
    let releaseDate: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
