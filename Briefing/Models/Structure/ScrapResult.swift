//
//  ScrapResult.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

protocol ScrapResult { }
extension ScrapResult {
    var isScrap: Bool {
        return self is CreateScrapResult
    }
}

struct CreateScrapResult: Codable, ScrapResult {
    let scrapId: Int
    let memberId: Int
    let briefingId: Int
    let createdAt: String
}

struct DeleteScrapResult: Codable, ScrapResult {
    let scrapId: Int
    let deletedAt: String
}
