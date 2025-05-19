//
//  NetworkProtocol.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit

protocol NetworkProtocol {
    func fetchData<T: Endpoint, M: Codable>(endPoint: T, response: M.Type, completion: @escaping(Result<M, ErrorMessage>) -> Void)
}
