//
//  BriefingNotificationManager.swift
//  Briefing
//
//  Created by BoMin Lee on 10/11/23.
//

import Foundation
import UserNotifications

class BriefingNotificationManager {
    static let shared = BriefingNotificationManager()
    
    private init() {} // Prevents others from creating another instance
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    var notificationTime: NotificationTime?
    
    func scheduleNotification(notificationTime: NotificationTime) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = BriefingStringCollection.Notification.notificationTitle.localized
        content.body = BriefingStringCollection.Notification.notificationBody.localized
        
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        switch notificationTime.meridiem {
        case 0:
            if notificationTime.hour == 12 {
                dateComponents.hour = 0
            }
            else {
                dateComponents.hour = notificationTime.hour
            }
        case 1:
            if notificationTime.hour == 12 {
                dateComponents.hour = 12
            }
            else {
                dateComponents.hour = notificationTime.hour+12
            }
        default:
            break
        }
        
        dateComponents.minute = notificationTime.minutes
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "DailyBriefing", content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func removeScheduledNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
}

