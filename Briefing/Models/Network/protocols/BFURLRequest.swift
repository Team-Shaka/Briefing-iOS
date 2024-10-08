//
//  BFURLRequestProtocol.swift
//  Briefing
//
//  Created by 이전희 on 10/6/23.
//

import Foundation
import Alamofire

enum BFHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol BFPath {
    var path: String { get }
    var available: [BFHTTPMethod] { get }
}

protocol BFQueryKey: Hashable {
    var rawValue: String { get }
}

protocol BFHTTPBodyKey: Hashable {
    var rawValue: String { get }
}

/// Briefing URL Request
/// API Path와 HttpMethod를 검사하여 잘못된 API 호출을 방지
protocol BFURLRequest: URLRequestConvertible {
    associatedtype Path: BFPath
    associatedtype QueryKey: BFQueryKey
    associatedtype HTTPBodyKey: BFHTTPBodyKey
    
    var accessToken: String? { get set }
    var urlRequest: URLRequest { get set }
    var httpMethod: BFHTTPMethod { get set }
    var path: Path  { get set }
    var httpBody: Data?  { get set }
    var query: [String: String]?  { get set }
    var timeoutInterval: TimeInterval  { get set }
    
    init(_accessToken: String?,
         _urlRequest: URLRequest,
         _method: BFHTTPMethod,
         _path: Path,
         _httpBody: Data?,
         _query: [String : String]?,
         _timeoutInterval: TimeInterval)
    
    init?(_ accessToken: String?,
          urlRequest: URLRequest,
          method: BFHTTPMethod,
          path: Path,
          httpBody: [HTTPBodyKey: Any]?,
          query: [QueryKey : String]?,
          timeoutInterval: TimeInterval)
    
    init?(_ accessToken: String?,
          url: URL,
          method: BFHTTPMethod,
          path: Path,
          httpBody: [HTTPBodyKey: Any]?,
          query: [QueryKey : String]?,
          timeoutInterval: TimeInterval)
    
    init(_ accessToken: String?,
         url: URL,
         method: BFHTTPMethod,
         path: Path,
         httpBodyDict: [String: Any],
         query: [String : String]?,
         timeoutInterval: TimeInterval)
}

extension BFURLRequest {
    init?(_ accessToken: String? = nil,
          urlRequest: URLRequest,
          method: BFHTTPMethod = .get,
          path: Path,
          httpBody: [HTTPBodyKey: Any]? = nil,
          query: [QueryKey: String]? = nil,
          timeoutInterval: TimeInterval = 10) {
        guard path.available.contains(method) else { return nil }
        var httpBodyData: Data? = nil
        if let httpBody = httpBody {
            let httpBodyDict = httpBody.dictMap({ ($0.rawValue, $1)})
            httpBodyData = try? JSONSerialization.data(withJSONObject: httpBodyDict)
        }
        let query = query?.dictMap({ ($0.rawValue, $1)})
        self.init(_accessToken: accessToken,
                  _urlRequest: urlRequest,
                  _method: method,
                  _path: path,
                  _httpBody: httpBodyData,
                  _query: query,
                  _timeoutInterval: timeoutInterval)
    }
    
    init?(_ accessToken: String? = nil,
          url: URL,
          method: BFHTTPMethod = .get,
          path: Path,
          httpBody: [HTTPBodyKey: Any]? = nil,
          query: [QueryKey : String]? = nil,
          timeoutInterval: TimeInterval = 10) {
        self.init(accessToken,
                  urlRequest: URLRequest(url: url),
                  method: method,
                  path: path,
                  httpBody: httpBody,
                  query: query,
                  timeoutInterval: timeoutInterval)
    }
    
    init(_ accessToken: String? = nil,
         url: URL,
         method: BFHTTPMethod = .get,
         path: Path,
         httpBodyDict: [String: Any],
         query: [String : String]? = nil,
         timeoutInterval: TimeInterval = 10) {
        let httpBodyData = try? JSONSerialization.data(withJSONObject: httpBodyDict,
                                                   options: .prettyPrinted)
        self.init(_accessToken: accessToken,
                  _urlRequest: URLRequest(url: url),
                  _method: method,
                  _path: path,
                  _httpBody: httpBodyData,
                  _query: query,
                  _timeoutInterval: timeoutInterval)
   }
    
    var queryItem: [URLQueryItem]? {
        return query?.compactMap({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })
    }
    
    /// URLRequestConvertible protocol function
    /// Alamofire에서 제공되는 URLRequestConvertible을 상속 받아 AF의 static function request에서 사용
    /// - Returns: URL Request
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Content-Type")
        if let accessToken = accessToken {
            urlRequest.setValue("Bearer \(accessToken)",
                                forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.httpBody = httpBody
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.url?.append(path: path.path)
        urlRequest.url?.append(queryItems: queryItem ?? [])
        return urlRequest
    }
}
