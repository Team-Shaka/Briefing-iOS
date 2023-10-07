//
//  Keywords.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

struct Keywords: Codable {
    let createdAt: Date
    let briefings: [KeywordBriefing]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = dateString.toDate(dataFormat: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
        self.briefings = try container.decode([KeywordBriefing].self, forKey: .briefings)
    }
}

struct KeywordBriefing: Codable {
    let id: Int
    let ranks: Int
    let title: String
    let subTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ranks
        case title
        case subTitle = "subtitle"
    }
}

