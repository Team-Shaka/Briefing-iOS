//
//  BriefingNetworkError.swift
//  Briefing
//
//  Created by 이전희 on 10/8/23.
//

import Foundation

enum BriefingNetworkError {
    case noAuthError
}

extension BriefingNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noAuthError: return NSLocalizedString("No Auth Error", comment: "")
        }
    }
}
