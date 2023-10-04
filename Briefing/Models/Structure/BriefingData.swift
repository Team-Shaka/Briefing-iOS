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
    
    enum CodingKeys: String, CodingKey {
        case id
        case ranks
        case title
        case subTitle = "subtitle"
        case content
        case date
        case articles
    }
}

struct BriefingCardArticle: Codable {
    let id: Int
    let press: String
    let title: String
    let url: String
}
