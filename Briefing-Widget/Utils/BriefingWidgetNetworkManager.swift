//
//  BriefingWidgetNetworkManager.swift
//  Briefing-WidgetExtension
//
//  Created by 이전희 on 10/31/23.
//

import Foundation

final class BriefingWidgetNetworkManager {
    static let shared: BriefingWidgetNetworkManager = BriefingWidgetNetworkManager()
    let baseUrl: URL
    private init() {
        self.baseUrl = BriefingURLManager.url(key: .baseUrl)
    }
}

extension BriefingWidgetNetworkManager {
    func keywordsReqeuest(type: String = "KOREA",
                          date: Date = Date(),
                          timeoutInterval: TimeInterval = 10) -> URLRequest {
        
        var url = self.baseUrl
        let queryItems = [("type", type),
                          ("date", date.dateToString())].map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        url.append(path: "briefings")
        url.append(queryItems: queryItems)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = timeoutInterval
        
        return urlRequest
    }
    
    func fetchKeywords(date: Date) async -> Keywords? {
        let urlRequest = self.keywordsReqeuest()
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let result = try JSONDecoder().decode(BriefingNetworkResult<Keywords>.self, from: data)
            return result.result
        } catch {
            return nil
        }
    }
}
