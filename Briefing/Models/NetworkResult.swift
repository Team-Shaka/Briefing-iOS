//
//  NetworkResult.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case badRequest
    case serverErr
    case notFound
    case networkFail
    case decodeFail
}
