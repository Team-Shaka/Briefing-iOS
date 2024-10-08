//
//  BriefingStringCollection.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/18.
//

import Foundation

protocol EnumeratedLocalized {
    var rawValue: String { get }
}

extension EnumeratedLocalized {
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}

final class BriefingStringCollection {
    private init() { }
    static let appName: String = NSLocalizedString("appName", comment: "")
    static let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let appDescription: String = NSLocalizedString("appDescription", comment: "")
    static let keywordBriefing: String = NSLocalizedString("keywordBriefing", comment: "")
    static let updated: String = NSLocalizedString("updated", comment: "")
    static let confirm: String = NSLocalizedString("confirm", comment: "")
    static let cancel: String = NSLocalizedString("cancel", comment: "")
    static let fail: String = NSLocalizedString("fail", comment: "")
    static let briefing: String = NSLocalizedString("briefing", comment: "")
    static let loading: String = NSLocalizedString("loading", comment: "")
    
    final class Format {
        private init() { }
        static let dateDotFormat = "yyyy.MM.dd"
        static let dateDashFormat = "yyyy-MM-dd"
        static let dateDetailDotFormat = "yyyy.MM.dd hha"
        static let dateDetailDashFormat = "yyyy-MM-dd hha"
        static let briefingServerTime = "yyyy-MM-dd'T'HH:mm:ss"
        static let briefingNotificationTime = "ahh:mm"
    }
    
    final class Locale {
        private init() { }
        static let ko = "ko_KR"
        static let en = "en_US"
    }
    
    enum Card: String, EnumeratedLocalized {
        case askBrief
        case beta
        case relatedArticles
    }
    
    enum Scrapbook: String, EnumeratedLocalized {
        case scrapbookTitle
    }
    
    enum Auth: String, EnumeratedLocalized {
        case signInWithApple
        case signInWithGoogle
        case signInLater
    }
    
    enum Setting: String, EnumeratedLocalized {
        case notification
        case appInfo
        case support
        case account
        
        case settings
        case notificationTimeSetting
        case appVersionTitle
        case feedbackAndInquiry
        case versionNote
        case termsOfService
        case privacyPolicy
        case caution
        case signInAndRegister
        case signIn
        case signOut
        case withdrawal
        case setting
        case setNotification
        case removeNotification
        case signOutDescription
        case withdrawalDescription
        case notificationTime
        case notificationTurnedOff
        case subscribe = "subscribeService"
    }
    
    enum Purchase: String, EnumeratedLocalized {
        case briefingPremium
        case briefingPremiumIntroduction
        case briefingPremiumDescription
        case briefingPremiumFirstDescription
        case briefingPremiumSecondDescription
        case briefingPremiumThirdDescription
        case briefingPremiumFourthDescription
        case briefingPremiumFifthDescription
        case briefingPremiumPurchaseYearly
        case briefingPremiumPurchaseMonthly
        case briefingPremiumPurchaseYearlyPrice
        case briefingPremiumPurchaseMonthlyPrice
    }
    
    enum Popup: String, EnumeratedLocalized {
        case signInRequired
        case signInRequiredDescription
    }
    
    enum Notification: String, EnumeratedLocalized {
        case notificationTitle
        case notificationBody
    }
    
    enum Link: String, EnumeratedLocalized {
        case feedBack = "feedBackLink"
        case versionNote = "versionNoteLink"
        case termsOfService = "termsOfServiceLink"
        case privacyPolicy = "privacyPolicyLink"
        case caution = "cautionLink"
    }
}
