//
//  UserNotification.swift
//  Briefing
//
//  Created by BoMin on 2023/08/28.
//

import Foundation
import UserNotifications

func scheduleNotification(at hour: Int) {
    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = "오늘의 브리핑이 도착하였습니다."
    content.body = "오늘의 주요한 키워드를 확인해 보세요!"
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.hour = hour
    // 매일 반복하도록 설정합니다.
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    let request = UNNotificationRequest(identifier: "DailyBriefing", content: content, trigger: trigger)
    center.add(request) { (error) in
        if let error = error {
            print("Error scheduling notification: \(error)")
        }
    }
}

