//
//  ScrapData.swift
//  Briefing
//
//  Created by BoMin on 2023/08/28.
//

import Foundation

struct Scrap {
    let id: String
    let rank: String
    let date: String
    let title: String
    let subtitle: String
    
    init(from string: String) {
        let components = string.split(separator: "\n").map { String($0) }
        self.id = components.count > 0 ? components[0] : ""
        self.rank = components.count > 1 ? components[1] : ""
        self.date = components.count > 2 ? components[2] : ""
        self.title = components.count > 3 ? components[3] : ""
        self.subtitle = components.count > 4 ? components[4] : ""
    }
    
    func toString() -> String {
        return [id, rank, date, title, subtitle].joined(separator: "\n")
    }
}

