//
//  Briefing.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct BriefingData {
    let id: Int
    let ranks: Int
    let title: String
    let subTitle: String?
    let content: String?
    let date: String
    let articles: [BriefingCardArticle]
    let isScrap: Bool
    let isBriefingOpen: Bool?
    let isWarning: Bool?
    let scrapCount: Int
    let gptModel: String
    let timeOfDay: String
    let type: String
}

struct BriefingCardArticle {
    let id: Int
    let press: String
    let title: String
    let url: String
}
