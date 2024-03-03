//
//  BriefingNetworkURLRequest.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation
import Alamofire

// MARK: - Category Mapping
extension BriefingCategory {
    var keywordType: KeywordsType {
        switch self {
        case .social: return .social
        case .science: return .science
        case .global: return .global
        case .economy: return .economy
        }
    }
}


// TODO: - POST
public struct BriefingEndpoint: BFEndpoints {
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
extension BriefingEndpoint {
    enum Path: BFPath {
        case root
        case keywords
        case briefingCard(id: Int)
        case chattings(id: Int?=nil)
        
        var path: String {
            switch self {
            case .root: return ""
            case .keywords: return "briefings"
            case let .briefingCard(id): return "briefings/\(id)"
            case let .chattings(id):
                guard let id = id else { return "chattings" }
                return "chattings/\(id)"
            }
        }
        
        var available: [BFHTTPMethod] {
            switch self {
            case .root: return [.get]
            case .keywords: return [.get, .post]
            case .briefingCard: return [.get]
            case .chattings: return [.get, .post]
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
