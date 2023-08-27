//
//  KeywordsData.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import Foundation

// MARK: - KeywordsData
struct KeywordsData: Codable {
    let createdAt: String
    let briefings: [Briefing]

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case briefings
    }
}

// MARK: - Briefing
struct Briefing: Codable {
    let id, rank: Int
    let title, subtitle: String
}

