//
//  ScrapEndpoint.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

public struct ScrapEndpoint: BFEndpoints {
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
extension ScrapEndpoint {
    enum Path: BFPath {
        case scrap
        case deleteScrap(id: Int, memberId: Int)
        case fetchScrap(memberId: Int)
        
        var path: String {
            switch self {
            case .scrap: return "scraps/briefings"
            case let .fetchScrap(memberId): return "scraps/briefings/members/\(memberId)"
            case let .deleteScrap(id, memberId):
                return "scraps/briefings/\(id)/members/\(memberId)"
            }
        }
        
        var available: [BFHTTPMethod] {
            switch self {
            case .scrap: return [.post]
            case .fetchScrap: return [.get]
            case .deleteScrap: return [.delete]
            }
        }
    }
    
    enum QueryKey: String, BFQueryKey {
        case date
        case type
        case timeOfDay
    }
    
    enum HTTPBodyKey: String, BFHTTPBodyKey {
        case memberId
        case briefingId
    }
}
