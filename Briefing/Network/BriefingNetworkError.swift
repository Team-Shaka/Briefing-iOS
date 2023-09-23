//
//  BriefingNetworkError.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation

enum BriefingNetworkError {
    case badRequestError
    case forbiddenError
    case notFoundError
    case internalServerError
    case networkError(statusCode: Int)
}

extension BriefingNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequestError: NSLocalizedString("Bad Request Error", comment: "")
        case .forbiddenError: NSLocalizedString("Forbidden Error", comment: "")
        case .notFoundError: NSLocalizedString("Not Found Error", comment: "")
        case .internalServerError: NSLocalizedString("Internal Server Error", comment: "")
        case let .networkError(statusCode): NSLocalizedString("Network Error(status code: \(statusCode)", comment: "")
        }
    }
}
