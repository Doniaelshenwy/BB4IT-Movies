//
//  NetworkManager.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit
import Alamofire

final class NetworkManager: NetworkProtocol {
    
    func fetchData<T: Endpoint, M: Codable>(endPoint: T, response: M.Type, completion: @escaping(Result<M, ErrorMessage>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: endPoint.method.rawValue)
        let headers = Alamofire.HTTPHeaders(endPoint.headers)
        let parameteres = buildParameters(task: endPoint.task)
        
        AF.request(
            endPoint.baseURL + endPoint.path,
            method: method,
            parameters: parameteres.0,
            encoding: parameteres.1,
            headers: headers
        ).response { response in
            switch response.result {
            case .success(let data):
                guard (response.response?.isSuccess ?? false) else {
                    return completion(.failure(.init(errorType: .serverError)))
                }
                guard let data else {
                    return completion(.failure(.init(errorType: .somethingWentWrong)))
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: data) else {
                    return completion(.failure(.init(errorType: .modelNotCorrect)))
                }
                completion(.success(responseObj))
            case .failure:
                return completion(.failure(.init(errorType: .serverError)))
            }
        }
    }
    
    private func buildParameters(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            ([:], URLEncoding.default)
        case .requestParameters(let parameters, let encoding):
            (parameters, encoding)
        }
    }
}

extension HTTPURLResponse {
    var isSuccess: Bool {
        switch statusCode {
        case 200 ... 399:
            return true
        default:
            return false
        }
    }
}

