//
//  BriefingFCMManager.swift
//  Briefing
//
//  Created by 이전희 on 2/20/24.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import RxSwift

final class BriefingFCMService: NSObject, BFNetworkService {
    
    static let shared: BriefingFCMService = BriefingFCMService()
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    var member: Member?
    
    private let disposeBag = DisposeBag()
    private var accept: Bool = false
    
    @discardableResult
    static func configure(_ application: UIApplication) -> BriefingFCMService {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        let fcmService = BriefingFCMService.shared
        fcmService.request()
            .subscribe() { _ in }
            .disposed(by: DisposeBag())
        application.registerForRemoteNotifications()
        Messaging.messaging().isAutoInitEnabled = true
        return fcmService
    }
    
    private override init() {
        super.init()
        defer {
            Messaging.messaging().delegate = self
        }
    }
    
    func request() -> Single<Bool> {
        UNUserNotificationCenter.current().delegate = self
        return Single<Bool>.create { promise in
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.sound,
                                                .alert,
                                                .badge]) { accept, error in
                                                    self.accept = accept
                                                }
            return Disposables.create()
        }
    }
}

private extension BriefingFCMService {
    func subscribe(_ fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
        print("🍎 fcm token:", fcmToken)
        print("🍎 access-token:", member?.accessToken)
        let url = BriefingURLContainer.url(key: .baseUrl)
    let urlRequest = BriefingFCMURLRequest(member?.accessToken,
                                               url: url,
                                               method: .post,
                                               path: .subscribe,
                                                     httpBody: [.token: fcmToken])
        if let urla = try? urlRequest.asURLRequest(),
           let data = urla.httpBody {
            print("😀", String(data: data, encoding: .utf8))
        }
        
        response(urlRequest)
            .subscribe { data in
                print("🍎subscribe - result:", String(data: data, encoding: .utf8))
            } onFailure: { error in
                print("🍎subscribe - error:", error)
            }
            .disposed(by: disposeBag)
    }
}

extension BriefingFCMService: MessagingDelegate {
    /// FCMToken 업데이트시
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        // subscribe(fcmToken)
        print(fcmToken)
    }
    
    /// 스위즐링 NO시, APNs등록, 토큰값가져옴
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("🟢", #function, deviceTokenString)
    }
    
    /// error발생시
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    }
}

extension BriefingFCMService: UNUserNotificationCenterDelegate{
    
    /// 푸시클릭시
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
    }
    
    /// 앱화면 보고있는중에 푸시올 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner, .list]
    }
}
