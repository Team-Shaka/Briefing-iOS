//
//  BriefingAuthURLRequest.swift
//  Briefing
//
//  Created by 이전희 on 10/6/23.
//

import Foundation
import Alamofire

// TODO: - POST
public struct BriefingAuthURLRequest: BFURLRequest {
    var urlRequest: URLRequest
    var httpMethod: BFHTTPMethod
    var path: Path
    var httpBody: Data?
    var query: [String: String]?
    var timeoutInterval: TimeInterval
    
    init(_urlRequest: URLRequest,
         _method: BFHTTPMethod,
         _path: Path,
         _httpBody: Data?,
         _query: [String : String]?,
         _timeoutInterval: TimeInterval) {
        self.urlRequest = _urlRequest
        self.httpMethod = _method
        self.path = _path
        self.httpBody = _httpBody
        self.query = _query
        self.timeoutInterval = _timeoutInterval
    }
}

// MARK: - URLRequest Management
extension BriefingAuthURLRequest {
    enum SocialType: String {
        case apple
        case google
    }
    
    enum Path: BFPath {
        case signIn(SocialType)
        case test
        case refresh
        
        var path: String {
            switch self {
            case let .signIn(socialType): return "members/auth/\(socialType)"
            case .test: return ""
            case .refresh: return "members/auth/token"
            }
        }
        
        var available: [BFHTTPMethod] {
            switch self {
            case .signIn: return [.post]
            case .test: return [.get]
            case .refresh: return [.post]
            }
        }
    }
    
    enum QueryKey: String, BFQueryKey {
        case none
    }
    
    enum HTTPBodyKey: String, BFHTTPBodyKey {
        case idToken = "identityToken"
        case refreshToken
    }
}
