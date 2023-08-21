//
//  BriefingCardData.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import Foundation

// MARK: - BriefingCardData
struct BriefingCardData: Codable {
    let id, rank: Int
    let title, subtitle, content: String
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let id: Int
    let press, title: String
    let url: String
}
