//
//  ScrapResult.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

struct ScrapResult: Codable {
    let scrapId: Int
    let memberId: Int
    let briefingId: Int
    let createdAt: String
}

struct DeleteScrapResult: Codable {
    let scrapId: Int
    let deletedAt: String
}
