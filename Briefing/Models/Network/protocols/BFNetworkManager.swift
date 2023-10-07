//
//  BFNetworkManager.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import Foundation
import Alamofire

protocol BFNetworkManager {
    func response<D: Codable>(_ briefingURLRequest: BriefingNetworkURLRequest,
                                type: D.Type,
                                completion: @escaping (_ value: D?, _ error: Error?) -> Void)
}

extension BFNetworkManager {
    func response<D: Codable>(_ briefingURLRequest: BriefingNetworkURLRequest,
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
