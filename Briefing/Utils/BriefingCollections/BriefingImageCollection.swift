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
    static let nextIconImage: UIImage = UIImage(named: "details_black")!
    static let scrapUnfilledImage: UIImage = #imageLiteral(resourceName: "scrap_normal")
    static let scrapFilledImage: UIImage = #imageLiteral(resourceName: "scrap_selected")
    static let chatGPTImage: UIImage = #imageLiteral(resourceName: "login_chatGPTBI")
    static let appleLogo: UIImage = UIImage(named: "login_apple")!
    static let googleLogo: UIImage = UIImage(named: "login_google")!
    static let backIconImage: UIImage = UIImage(named: "arrow_blue")!
    static let backIconBlackImage: UIImage = #imageLiteral(resourceName: "arrow_left_black")
    static let othersIconBlackImage: UIImage = #imageLiteral(resourceName: "others_black")
    static let scrapCountImage: UIImage = UIImage(named: "scrap_count")!
    static let fetchImage: UIImage = UIImage(named: "fetch")!
    
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
