//
//  BriefingData.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

struct BriefingData: Codable {
    let id: Int
    let ranks: Int
    let title: String
    let subTitle: String
    let content: String
    let date: String
    let articles: [BriefingCardArticle]
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

struct BriefingCardArticle: Codable {
    let id: Int
    let press: String
    let title: String
    let url: String
}
