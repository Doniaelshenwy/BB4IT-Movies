//
//  RequestBase.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import Alamofire

enum HttpMethod: String {
    case GET
}

enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get}
    var task: Task { get }
    var headers: [String: String] { get }
}

extension Endpoint {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var headers: [String: String] {
        return ["Authorization" : "Bearer \(Constants.bearerToken)"]
    }
}
