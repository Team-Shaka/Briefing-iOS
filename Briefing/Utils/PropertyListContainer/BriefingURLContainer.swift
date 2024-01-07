//
//  BriefingURLContainer.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation

// MARK: - url.plist Key Management
enum BriefingURLKey: String {
    case baseUrl = "briefing"
}

final class BriefingURLContainer {
    private init() { }
    
    /// Briefing URL function
    /// - Parameter key: briefingUrlKey
    /// - Returns: URL
    static func url(key: BriefingURLKey) -> URL {
        #if DEBUG
        guard let fileUrl = Bundle.main.url(forResource: "url-debug", withExtension: "plist") else { fatalError("DOSEN'T EXIST URL FILE") }
        #else
        guard let fileUrl = Bundle.main.url(forResource: "url", withExtension: "plist") else { fatalError("DOSEN'T EXIST URL FILE") }
        #endif
        guard let urlDictionary = NSDictionary(contentsOf: fileUrl) else { fatalError("DOSEN'T EXIST URL KEY") }
        guard let urlString = urlDictionary[key.rawValue] as? String else { fatalError("COULDN'T CONVERT TO STRING") }
        guard let url = URL(string: urlString) else { fatalError("COULDN'T CREATE URL") }
        
        return url
    }
    
    /// Breifing URL Request function
    /// - Parameter key: briefingUrlKey
    /// - Returns: URLRequest
    static func urlRequest(key: BriefingURLKey) -> URLRequest {
        let url = BriefingURLContainer.url(key: key)
        return URLRequest(url: url)
    }
}
