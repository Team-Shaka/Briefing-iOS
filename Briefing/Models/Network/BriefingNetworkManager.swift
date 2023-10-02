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

extension BriefingNetworkManager {
    func fetchKeywords(date: String,
                       type: String,
                       completion: @escaping (_ value: KeywordsData?, _ error: Error?) -> Void) {
        let url = BriefingURLManager.url(key: .baseUrl)
        let briefingURLRequest = BriefingURLRequest(url: url,
                                                    method: .get,
                                                    path: .keywords,
                                                    query: [.date: date,
                                                            .type: type])
        response(briefingURLRequest,
                 type: KeywordsData.self,
                 completion: completion)
    }
    
    func fetchBriefingCard(id: String,
                           completion: @escaping (_ value: BriefingCardData?, _ error: Error?) -> Void) {
        let url = BriefingURLManager.url(key: .baseUrl)
        let briefingURLRequest = BriefingURLRequest(url: url,
                                                    method: .get,
                                                    path: .briefingCard(id: id))
        response(briefingURLRequest,
                 type: BriefingCardData.self,
                 completion: completion)
    }
}

private extension BriefingNetworkManager {
    func response<D: Decodable>(_ briefingURLRequest: BriefingURLRequest,
                                type: D.Type,
                                completion: @escaping (_ value: D?, _ error: Error?) -> Void) {
        AF.request(briefingURLRequest)
            .responseDecodable(of: type) { response in
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
                    completion(response.value, response.error)
                } catch {
                    completion(nil, error)
                }
            }
    }
}


