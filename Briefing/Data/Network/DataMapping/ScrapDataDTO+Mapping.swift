//
//  ScrapDataDTO+Mapping.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct ScrapDataDTO: Codable {
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

extension ScrapDataDTO {
    func toDomain() -> ScrapData {
        ScrapData(briefingId: briefingId, 
                  ranks: ranks,
                  title: title,
                  subTitle: subTitle,
                  date: date,
                  gptModel: gptModel,
                  timeOfDay: timeOfDay)
    }
}
