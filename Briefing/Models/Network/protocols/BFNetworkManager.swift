//
//  BFNetworkManager.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import Foundation
import Alamofire

protocol BFNetworkManager {
    func response<D: Codable>(_ briefingURLRequest: any BFURLRequest,
                                type: D.Type,
                                completion: @escaping (_ value: D?, _ error: Error?) -> Void)
    
    func response(_ briefingURLRequest: any BFURLRequest,
                  completion: @escaping (_ value: Data?, _ error: Error?) -> Void)
}

extension BFNetworkManager {
    func response<D: Codable>(_ briefingURLRequest: any BFURLRequest,
                                type: D.Type,
                                completion: @escaping (_ value: D?, _ error: Error?) -> Void) {
        AF.request(briefingURLRequest)
            .responseDecodable(of: BriefingNetworkResult<D>.self) { response in
                do {
                    if let statusCode =  response.response?.statusCode {
                        switch statusCode {
                        case (200..<400): break
                        case (400): throw BFNetworkError.badRequestError
                        case (404): throw BFNetworkError.notFoundError
                        case (403): throw BFNetworkError.forbiddenError
                        case (500): throw BFNetworkError.internalServerError
                        default: throw BFNetworkError.networkError(statusCode: statusCode)
                        }
                    }
                    guard let networkResult = response.value else {
                        completion(nil, response.error)
                        return
                    }
                    
                    guard networkResult.isSuccess else {
                        completion(nil, BFNetworkError.requestFail(code: networkResult.code,
                                                                   message: networkResult.message))
                        return
                    }
                    
                    completion(networkResult.result, response.error)
                } catch {
                    completion(nil, error)
                }
            }
    }
    
    func response(_ briefingURLRequest: any BFURLRequest,
                  completion: @escaping (_ value: Data?, _ error: Error?) -> Void) {
        AF.request(briefingURLRequest)
            .responseData { response in
                completion(response.value, response.error)
            }
    }
}
