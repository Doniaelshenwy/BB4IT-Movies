//
//  ErrorMessage.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import Foundation

struct ErrorMessage: LocalizedError, Decodable {
    var errorType: ErrorMessageTypes?
    
    init(errorType: ErrorMessageTypes) {
        self.errorType = errorType
    }
}

enum ErrorMessageTypes: Decodable {
    case serverError
    case somethingWentWrong
    case modelNotCorrect
    
    var errorDescription: String {
        switch self {
        case .serverError:
            return "Unfortunitly Server error!, try again later"
        case .somethingWentWrong:
            return "There is error occured, try again later"
        case .modelNotCorrect:
            return "Entity is Wrong"
        }
    }
}

