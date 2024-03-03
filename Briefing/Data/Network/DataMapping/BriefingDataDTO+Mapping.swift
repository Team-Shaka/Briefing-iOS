//
//  BriefingDataDTO+Mapping.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct BriefingDataDTO: Codable {
    let id: Int
    let ranks: Int
    let title: String
    let subTitle: String?
    let content: String?
    let date: String
    let articles: [BriefingCardArticleDTO]
    let isScrap: Bool
    let isBriefingOpen: Bool?
    let isWarning: Bool?
    let scrapCount: Int
    let gptModel: String
    let timeOfDay: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ranks
        case title
        case subTitle = "subtitle"
        case content
        case date
        case articles
        case isScrap
        case isBriefingOpen
        case isWarning
        case scrapCount
        case gptModel
        case timeOfDay
        case type
    }
}

struct BriefingCardArticleDTO: Codable {
    let id: Int
    let press: String
    let title: String
    let url: String
}

extension BriefingDataDTO {
    func toDomain() -> BriefingData {
        BriefingData(id: id,
                     ranks: ranks,
                     title: title,
                     subTitle: subTitle,
                     content: content,
                     date: date,
                     articles: articles.map { $0.toDomain() },
                     isScrap: isScrap,
                     isBriefingOpen: isBriefingOpen,
                     isWarning: isWarning,
                     scrapCount: scrapCount,
                     gptModel: gptModel,
                     timeOfDay: timeOfDay,
                     type: type)
    }
}

extension BriefingCardArticleDTO {
    func toDomain() -> BriefingCardArticle {
        BriefingCardArticle(id: id,
                            press: press,
                            title: title,
                            url: url)
    }
}
