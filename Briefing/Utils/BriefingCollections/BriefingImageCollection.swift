//
//  BriefingImageCollection.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/18.
//

import UIKit

final class BriefingImageCollection {
    private init() { }
    
    static let scrapImage: UIImage = #imageLiteral(resourceName: "storage")
    static let settingImage: UIImage = #imageLiteral(resourceName: "setting")
    static let briefingTabBarNormalIconImage: UIImage = #imageLiteral(resourceName: "briefing_normal")
    static let briefingTabBarSelectedIconImage: UIImage = #imageLiteral(resourceName: "briefing_selected")
    static let chatTabBarNormalIconImage: UIImage = #imageLiteral(resourceName: "chat_normal")
    static let chatTabBarSelectedIconImage: UIImage = #imageLiteral(resourceName: "chat_selelcted")
//    static let nextIconImage: UIImage = UIImage(systemName: "chevron.forward")!
    static let nextIconImage: UIImage = #imageLiteral(resourceName: "details")
    static let scrapUnfilledImage: UIImage = #imageLiteral(resourceName: "scrap_normal")
    static let scrapFilledImage: UIImage = #imageLiteral(resourceName: "scrap_selected")
    
    final class Setting {
        private init() { }
        static let caution: UIImage = UIImage(named: "setting_caution")!
        static let clock: UIImage = UIImage(named: "setting_clock")!
        static let feedback: UIImage = UIImage(named: "setting_feedback")!
        static let termsOfService: UIImage = UIImage(named: "setting_policy")!
        static let privacyPolicy: UIImage = UIImage(named: "setting_policy")!
        static let versionNote: UIImage = UIImage(named: "setting_version_note")!
        static let appVersion: UIImage = UIImage(named: "setting_version")!
    }
    
    final class Card {
        private init() { }
        static let briefChatBeta: UIImage = UIImage(named: "brief_chat_beta")!
    }

}
