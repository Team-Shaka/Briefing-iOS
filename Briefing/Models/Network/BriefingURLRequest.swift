//
//  BriefingURLRequest.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation
import Alamofire

// TODO: - POST
public struct BriefingURLRequest: URLRequestConvertible {
    private let urlRequest: URLRequest
    private let httpMethod: HTTPMethod
    private let path: Path
    private let httpBody: String?
    private let query: [String: String]?
    private let timeoutInterval: TimeInterval
    
    init?(urlRequest: URLRequest,
         method: HTTPMethod = .get,
         path: Path,
         httpBody: String? = nil,
         query: [QueryKey : String]? = nil,
         timeoutInterval: TimeInterval = 10) {
        guard !path.available.contains(method) else { return nil }
        self.urlRequest = urlRequest
        self.httpMethod = method
        self.path = path
        self.httpBody = httpBody
        self.query = Dictionary(uniqueKeysWithValues: query?.map{ ($0.rawValue, $1) } ?? [])
        self.timeoutInterval = timeoutInterval
    }
    
    init?(url: URL,
         method: HTTPMethod = .get,
         path: Path,
         httpBody: String? = nil,
         query: [QueryKey : String]? = nil,
         timeoutInterval: TimeInterval = 10
    ) {
        self.init(urlRequest: URLRequest(url: url),
                  method: method,
                  path: path,
                  httpBody: httpBody,
                  query: query,
                  timeoutInterval: timeoutInterval)
    }
    
    var queryItem: [URLQueryItem]? {
        return query?.compactMap({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })
    }
    
    /// URLRequestConvertible protocol function
    /// - Returns: URL Request
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.httpMethod = httpMethod.rawValue
        switch httpMethod {
        case .get: urlRequest.headers = ["Content-Type":"application/json", "Accept":"application/json"]
        case .post: urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        default: break
        }
        urlRequest.timeoutInterval = timeoutInterval
        let appendedUrl = urlRequest.url?.appending(component: path.path)
        urlRequest.url = appendedUrl
        urlRequest.url?.append(queryItems: queryItem ?? [])
        return urlRequest
    }
}

extension BriefingURLRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    // MARK: - Briefing Path Management
    enum Path {
        case root
        case keywords
        case briefingCard(id: String)
        case chattings(id: String?=nil)
        case scrap
        case deleteScrap(id: String)
        case fetchScrap(memberId: String)
        
        var path: String {
            switch self {
            case .root: return ""
            case .keywords: return "briefings"
            case let .briefingCard(id): return "briefings/\(id)"
            case let .chattings(id):
                guard let id = id else { return "chattings" }
                return "chattings/\(id)"
            case .scrap: return "scraps/briefings"
            case let .fetchScrap(memberId): return "scraps/briefings/members\(memberId)"
            case let .deleteScrap(id): return "scraps/\(id)"
            }
        }
        
        var available: [HTTPMethod] {
            switch self {
            case .root: return [.get]
            case .keywords: return [.get, .post]
            case .briefingCard: return [.get]
            case .chattings: return [.get, .post]
            case .scrap: return [.post]
            case .fetchScrap: return [.get]
            case .deleteScrap: return [.delete]
            }
        }
    }
    
    enum QueryKey: String {
        case date
        case type
    }
}
