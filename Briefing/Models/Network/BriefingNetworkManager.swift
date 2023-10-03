//
//  NetworkManager.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation
import Alamofire

final class BriefingNetworkManager {
    static let shared: BriefingNetworkManager = BriefingNetworkManager()
    private init() { }
}

// MARK: - StringQueryValue
extension BriefingNetworkManager {
    enum KeywordsType: String {
        case korea = "KOREA"
        case global = "GLOBAL"
    }
}

// MARK: - fetch Functions
extension BriefingNetworkManager {
    func fetchKeywords(date: Date,
                       type: KeywordsType,
                       completion: @escaping (_ value: Keywords?, _ error: Error?) -> Void) {
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let briefingURLRequest = BriefingURLRequest(url: url,
                                                          method: .get,
                                                          path: .keywords,
                                                          query: [.date: date.dateToString(),
                                                                  .type: type.rawValue]) else {
            completion(nil, BriefingNetworkError.wrongURLRequestError)
            return
        }
        
        response(briefingURLRequest,
                 type: Keywords.self,
                 completion: completion)
    }
    
    func fetchBriefingCard(id: String,
                           completion: @escaping (_ value: BriefingData?, _ error: Error?) -> Void) {
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let briefingURLRequest = BriefingURLRequest(url: url,
                                                          method: .get,
                                                          path: .briefingCard(id: id)) else {
            completion(nil, BriefingNetworkError.wrongURLRequestError)
            return
        }
        response(briefingURLRequest,
                 type: BriefingData.self,
                 completion: completion)
    }
    
    // func scrapBriefingCard(id: String,
    //                        completion: @escaping (_ value: ScrapResult?, _ error: Error?) -> Void) {
    //     let url = BriefingURLManager.url(key: .baseUrl)
    //     guard let briefingURLRequest = BriefingURLRequest(url: url,
    //                                                       method: .post,
    //                                                       path: .scrap,
    //                                                       httpBody: <#T##String?#>) else {
    //         
    //     }
    // }
}

// MARK: - Networking
private extension BriefingNetworkManager {
    func response<D: Codable>(_ briefingURLRequest: BriefingURLRequest,
                                type: D.Type,
                                completion: @escaping (_ value: D?, _ error: Error?) -> Void) {
        AF.request(briefingURLRequest)
            .responseDecodable(of: BriefingNetworkResult<D>.self) { response in
                do {
                    if let statusCode =  response.response?.statusCode {
                        switch statusCode {
                        case (200..<400): break
                        case (400): throw BriefingNetworkError.badRequestError
                        case (404): throw BriefingNetworkError.notFoundError
                        case (403): throw BriefingNetworkError.forbiddenError
                        case (500): throw BriefingNetworkError.internalServerError
                        default: throw BriefingNetworkError.networkError(statusCode: statusCode)
                        }
                    }
                    completion(response.value?.result, response.error)
                } catch {
                    completion(nil, error)
                }
            }
    }
}


