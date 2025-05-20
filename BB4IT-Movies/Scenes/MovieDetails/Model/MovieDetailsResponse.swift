//
//  MovieDetailsResponse.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 20/05/2025.
//

import Foundation

struct MovieDetailsResponse: Codable {
 
    let genres: [GenreResponse]?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case genres
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

struct GenreResponse: Codable {
    let id: Int?
    let name: String?
}
