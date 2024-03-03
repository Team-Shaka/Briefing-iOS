//
//  BFNetworkError.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation

enum BFNetworkError {
    case wrongURLRequestError
    case badRequestError
    case forbiddenError
    case notFoundError
    case internalServerError
    case networkError(statusCode: Int)
    case requestFail(code: String, message: String)
}

extension BFNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .wrongURLRequestError: return NSLocalizedString("Wrong URL Request Error", comment: "")
        case .badRequestError: return NSLocalizedString("Bad Request Error", comment: "")
        case .forbiddenError: return NSLocalizedString("Forbidden Error", comment: "")
        case .notFoundError: return NSLocalizedString("Not Found Error", comment: "")
        case .internalServerError: return NSLocalizedString("Internal Server Error", comment: "")
        case let .networkError(statusCode): return NSLocalizedString("Network Error(status code: \(statusCode)", comment: "")
        case let .requestFail(_, message): return NSLocalizedString(message, comment: "")
        }
    }
}
