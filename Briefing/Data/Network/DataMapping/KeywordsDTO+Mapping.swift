//
//  KeywordsDTO+Mapping.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct KeywordsDTO: Codable {
    let createdAt: Date
    let briefings: [KeywordBriefingDTO]
    
    init(createdAt: Date,
         briefings: [KeywordBriefingDTO]){
        self.createdAt = createdAt
        self.briefings = briefings
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = dateString.components(separatedBy: ".")
            .first?
            .toDate(dataFormat: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
        self.briefings = try container.decode([KeywordBriefingDTO].self, forKey: .briefings)
            .sorted(by: { $0.ranks < $1.ranks })
    }
}

struct KeywordBriefingDTO: Codable {
    let id: Int
    let ranks: Int
    let title: String
    let subTitle: String
    let scrapCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case ranks
        case title
        case subTitle = "subtitle"
        case scrapCount
    }
}

extension KeywordsDTO {
    func toDomain() -> Keywords {
        Keywords(createdAt: createdAt,
                 briefings: briefings.map { $0.toDomain() })
    }
}

extension KeywordBriefingDTO {
    func toDomain() -> KeywordBriefing {
        KeywordBriefing(id: id, 
                        ranks: ranks,
                        title: title,
                        subTitle: subTitle,
                        scrapCount: scrapCount)
    }
}
