//
//  NotificationTime.swift
//  Briefing
//
//  Created by 이전희 on 10/10/23.
//

import Foundation

struct NotificationTime: Codable {
    let meridiem: Int
    let hour: Int
    let minutes: Int
    
    func toString() -> String {
        let meridiemText = meridiem == 0 ? "AM" : "PM"
        let hourText = hour >= 10 ? "\(hour)" : "0\(hour)"
        let minutesText = minutes >= 10 ? "\(minutes)" : "0\(minutes)"
        return "\(meridiemText) \(hourText):\(minutesText)"
    }
}
