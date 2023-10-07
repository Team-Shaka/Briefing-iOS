//
//  NetworkManager.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation
import Alamofire

final class BriefingNetworkManager: BFNetworkManager {
    static let shared: BriefingNetworkManager = BriefingNetworkManager()
    private init() { }
}

// MARK: - functions for Briefing API
extension BriefingNetworkManager {
    func fetchKeywords(date: Date,
                       type: BriefingNetworkURLRequest.KeywordsType,
                       completion: @escaping (_ value: Keywords?, _ error: Error?) -> Void) {
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let urlRequest = BriefingNetworkURLRequest(url: url,
                                                          method: .get,
                                                          path: .keywords,
                                                          query: [.date: date.dateToString(),
                                                                  .type: type.rawValue]) else {
            completion(nil, BriefingNetworkError.wrongURLRequestError)
            return
        }
        
        response(urlRequest,
                 type: Keywords.self,
                 completion: completion)
    }
    
    func fetchBriefingCard(id: String,
                           completion: @escaping (_ value: BriefingData?, _ error: Error?) -> Void) {
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let urlRequest = BriefingNetworkURLRequest(url: url,
                                                          method: .get,
                                                          path: .briefingCard(id: id)) else {
            completion(nil, BriefingNetworkError.wrongURLRequestError)
            return
        }
        response(urlRequest,
                 type: BriefingData.self,
                 completion: completion)
    }
    
    // func scrapBriefingCard(id: String,
    //                        completion: @escaping (_ value: ScrapResult?, _ error: Error?) -> Void) {
    //     let url = BriefingURLManager.url(key: .baseUrl)
    //     guard let urlRequest = BriefingURLRequest(url: url,
    //                                                       method: .post,
    //                                                       path: .scrap,
    //                                                       httpBody: <#T##String?#>) else {
    //         
    //     }
    // }
}
