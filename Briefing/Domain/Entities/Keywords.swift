//
//  Keywords.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct Keywords {
    let createdAt: Date
    let briefings: [KeywordBriefing]
}

struct KeywordBriefing {
    let id: Int
    let ranks: Int
    let title: String
    let subTitle: String
    let scrapCount: Int
    
    var scrapCountText: String {
        return scrapCount >= 1000 ? "+\(scrapCount/1000)K" : "+\(scrapCount)"
    }
}
