//
//  BriefingFCMURLRequest.swift
//  Briefing
//
//  Created by 이전희 on 2/20/24.
//

import Foundation

public struct BriefingFCMURLRequest: BFURLRequest {
    var accessToken: String?
    var urlRequest: URLRequest
    var httpMethod: BFHTTPMethod
    var path: Path
    var httpBody: Data?
    var query: [String: String]?
    var timeoutInterval: TimeInterval
    
    init(_accessToken: String?,
         _urlRequest: URLRequest,
         _method: BFHTTPMethod,
         _path: Path,
         _httpBody: Data?,
         _query: [String : String]?,
         _timeoutInterval: TimeInterval) {
        self.accessToken = _accessToken
        self.urlRequest = _urlRequest
        self.httpMethod = _method
        self.path = _path
        self.httpBody = _httpBody
        self.query = _query
        self.timeoutInterval = _timeoutInterval
    }
}

// MARK: - URLRequest Management
extension BriefingFCMURLRequest {
    enum Path: BFPath {
        case subscribe
        case unsubscribe
        
        var path: String {
            switch self {
            case .subscribe: return "pushs/subscribe"
            case .unsubscribe: return "pushs/unsubscribe"
            }
        }
        
        var available: [BFHTTPMethod] {
            switch self {
            case .subscribe: return [.post]
            case .unsubscribe: return [.post]
            }
        }
    }
    
    enum QueryKey: String, BFQueryKey {
        case none
    }
    
    enum HTTPBodyKey: String, BFHTTPBodyKey {
        case token
    }
}
