//
//  Scrap.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import Foundation

struct ScrapData: Codable {
    let briefingId: Int
    let ranks: Int
    let title: String
    let subTitle: String
    let date: String
    let gptModel: String
    let timeOfDay: String
    
    enum CodingKeys: String, CodingKey {
        case briefingId
        case ranks
        case title
        case subTitle = "subtitle"
        case date
        case gptModel
        case timeOfDay
    }
}
