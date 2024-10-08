//
//  Keywords.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

struct Keywords: Codable {
    let createdAt: Date
    // let type: String
    let briefings: [KeywordBriefing]
    
    init(createdAt: Date,
         // type: String,
         briefings: [KeywordBriefing]){
        self.createdAt = createdAt
        // self.type = type
        self.briefings = briefings
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = dateString.components(separatedBy: ".")
            .first?
            .toDate(dataFormat: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
        // self.type = try container.decode(String.self, forKey: .type)
        self.briefings = try container.decode([KeywordBriefing].self, forKey: .briefings)
            .sorted(by: { $0.ranks < $1.ranks })
    }
}

struct KeywordBriefing: Codable {
    let id: Int
    let ranks: Int
    let title: String
    let subTitle: String
    let scrapCount: Int
    
    var scrapCountText: String {
        return scrapCount >= 1000 ? "+\(scrapCount/1000)K" : "+\(scrapCount)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case ranks
        case title
        case subTitle = "subtitle"
        case scrapCount
    }
}
