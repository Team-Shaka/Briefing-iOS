//
//  BriefingNetworkResult.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

struct BriefingNetworkResult<T: Codable>: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T?
}
