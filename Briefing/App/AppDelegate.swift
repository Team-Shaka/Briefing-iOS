//
//  AppDelegate.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import UIKit
import UserNotifications
import FirebaseCore
import GoogleMobileAds
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    @UserDefaultWrapper(key: .isFirstLaunchAppWithNotification, defaultValue: nil)
    var isFirstLaunchAppWithNotification: Bool?
    @UserDefaultWrapper(key: .notificationTime, defaultValue: nil)
    var notificationTime: NotificationTime?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    guard self.isFirstLaunchAppWithNotification == nil else { return }
                    let notificationTime = NotificationTime(meridiem: 0, hour: 7, minutes: 0)
                    self.notificationTime = notificationTime
                    BriefingNotificationManager.shared
                        .scheduleNotification(notificationTime: notificationTime)
                    self.isFirstLaunchAppWithNotification = false
                }
        }
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        FirebaseApp.configure()
        setupFCM(application)
        
        return true
    }
    //MARK: FCM Connecting
    private func setupFCM(_ application: UIApplication) {
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { isAgree, error in
            if isAgree {
                print("알림 허용")
            }
        }
        application.registerForRemoteNotifications()
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
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

