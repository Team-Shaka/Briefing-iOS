//
//  BriefingAuthError.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import Foundation

enum BriefingAuthError {
    case invalidTokenError
    case wrongAccessError
    case wrongURLReqeustError
    case noDataError
}

extension BriefingAuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidTokenError: return NSLocalizedString("Invalid Token Error", comment: "")
        case .wrongAccessError: return NSLocalizedString("Wrong Access Error", comment: "")
        case .wrongURLReqeustError: return NSLocalizedString("Wrong URLRequest Error", comment: "")
        case .noDataError: return NSLocalizedString("No Data Error", comment: "")
        }
    }
}
