//
//  ScrapResultDTO+Mapping.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

protocol ScrapResultType { }
extension ScrapResultType {
    var isScrapped: Bool {
        return self is CreateScrapResultDTO
    }
    
    func toDomain() -> ScrapResult {
        ScrapResult(isScrapped: isScrapped)
    }
}

struct CreateScrapResultDTO: Codable, ScrapResultType {
    let scrapId: Int
    let memberId: Int
    let briefingId: Int
    let createdAt: String
}

struct DeleteScrapResultDTO: Codable, ScrapResultType {
    let scrapId: Int
    let deletedAt: String
}
