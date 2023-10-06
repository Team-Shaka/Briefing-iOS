//
//  BriefingURLRequestProtocol.swift
//  Briefing
//
//  Created by 이전희 on 10/6/23.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol BriefingPathProtocol {
    var path: String { get }
    var available: [HTTPMethod] { get }
}

protocol BriefingQueryKeyProtocol: Hashable {
    var rawValue: String { get }
}

protocol BriefingURLRequestProtocol: URLRequestConvertible {
    associatedtype Path: BriefingPathProtocol
    associatedtype QueryKey: BriefingQueryKeyProtocol
    
    var urlRequest: URLRequest { get set }
    var httpMethod: HTTPMethod { get set }
    var path: Path  { get set }
    var httpBody: String?  { get set }
    var query: [String: String]?  { get set }
    var timeoutInterval: TimeInterval  { get set }
    
    init?(urlRequest: URLRequest,
         method: HTTPMethod,
         path: Path,
         httpBody: String?,
         query: [QueryKey : String]?,
         timeoutInterval: TimeInterval)
    
    init?(url: URL,
         method: HTTPMethod,
         path: Path,
         httpBody: String?,
         query: [QueryKey : String]?,
         timeoutInterval: TimeInterval)
}

extension BriefingURLRequestProtocol {
    private init(){
       fatalError("Don't use the default URLRequest Initializer")
    }
    
    init?(urlRequest: URLRequest,
         method: HTTPMethod = .get,
         path: Path,
         httpBody: String? = nil,
         query: [QueryKey : String]? = nil,
         timeoutInterval: TimeInterval = 10) {
        guard path.available.contains(method) else { return nil }
        self.init()
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
         timeoutInterval: TimeInterval = 10) {
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
        case .get: urlRequest.headers = ["Content-Type":"application/json",
                                         "Accept":"application/json"]
        case .post: urlRequest.setValue("application/json", 
                                        forHTTPHeaderField: "Content-Type")
        default: break
        }
        urlRequest.timeoutInterval = timeoutInterval
        let appendedUrl = urlRequest.url?.appending(component: path.path)
        urlRequest.url = appendedUrl
        urlRequest.url?.append(queryItems: queryItem ?? [])
        return urlRequest
    }
}
