//
//  BriefingNotificationManager.swift
//  Briefing
//
//  Created by BoMin Lee on 10/11/23.
//

import Foundation
import UserNotifications
import RxSwift

class BriefingNotificationManager {
    static let shared = BriefingNotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {} // Prevents others from creating another instance
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    var notificationTime: NotificationTime?
    
    func scheduleNotification(notificationTime: NotificationTime) {
        let content = UNMutableNotificationContent()
        content.title = BriefingStringCollection.Notification.notificationTitle.localized
        content.body = BriefingStringCollection.Notification.notificationBody.localized
        
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = (notificationTime.hour % 12) + (notificationTime.meridiem * 12)
        dateComponents.minute = notificationTime.minutes
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: .dailyBriefing, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func removeScheduledNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func isNotificationPermissionGranted(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                completion(true)
            case .denied, .notDetermined:
                completion(false)
            @unknown default:
                completion(false)
            }
        }
    }
    
    func isNotificationPermissionGranted() -> Single<Bool> {
        Single.create { single in
            self.notificationCenter.getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    single(.success(true))
                case .denied, .notDetermined:
                    single(.success(true))
                @unknown default:
                    single(.success(true))
                }
            }
            return Disposables.create()
        }
    }
}

extension UNNotificationRequest {
    enum UNNotificationRequestIndentifier: String {
        case dailyBriefing
    }
    
    convenience init(identifier: UNNotificationRequestIndentifier,
                     content: UNMutableNotificationContent,
                     trigger: UNCalendarNotificationTrigger) {
        self.init(identifier: identifier.rawValue,
                  content: content,
                  trigger: trigger)
    }
}

