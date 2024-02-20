//
//  BriefingFCMManager.swift
//  Briefing
//
//  Created by 이전희 on 2/20/24.
//

import Foundation
import FirebaseCore
import FirebaseMessaging

final class BriefingFCMService: NSObject {
    
    // MARK: - static properties
    static let shared: BriefingFCMService = BriefingFCMService()
    
    static func configure(_ application: UIApplication) -> BriefingFCMService {
        FirebaseApp.configure()
        let fcmService = BriefingFCMService.shared
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.sound,
                                            .alert,
                                            .badge]) { isAgree, error in
                                                if isAgree {
                                                    print("알림 허용")
                                                }
            }
        application.registerForRemoteNotifications()
        return fcmService
    }
    
    
    private override init() {
        super.init()
        defer {
            Messaging.messaging().delegate = self
            UNUserNotificationCenter.current().delegate = self
        }
    }
}

extension BriefingFCMService: UNUserNotificationCenterDelegate,
                              MessagingDelegate {
    /// 푸시클릭시
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("🟢", #function)
    }
    
    /// 앱화면 보고있는중에 푸시올 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        print("🟢", #function)
        return [.sound, .banner, .list]
    }
    
    /// FCMToken 업데이트시
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("🟢", #function, fcmToken)
    }
    
    /// 스위즐링 NO시, APNs등록, 토큰값가져옴
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("🟢", #function, deviceTokenString)
    }
    
    /// error발생시
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("🟢", error)
    }
}



