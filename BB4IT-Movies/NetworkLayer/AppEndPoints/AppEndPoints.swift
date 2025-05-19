//
//  AppEndPoints.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import Alamofire

enum AppEndPoints {
    case getMovies(String)
    case getMovieDetails(Int)
}

extension AppEndPoints: Endpoint {

    var path: String {
        switch self {
        case .getMovies(let type):
            return "\(type)"
        case .getMovieDetails(let id):
            return "\(id)"
        }
    }
    
    var method: HttpMethod {
        .GET
    }
    
    var task: Task {
        .requestPlain
    }
}
