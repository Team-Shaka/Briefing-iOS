//
//  Keywords.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

struct Keywords: Codable {
    let createdAt: String
    let briefings: [KeywordBriefing]
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

