//
//  BriefingImageCollection.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/18.
//

import UIKit

final class BriefingImageCollection {
    private init() { }
    
    static let storageImage: UIImage = #imageLiteral(resourceName: "storage")
    static let settingImage: UIImage = #imageLiteral(resourceName: "setting")
    static let briefingTabBarNormalIconImage: UIImage = #imageLiteral(resourceName: "briefing_normal")
    static let briefingTabBarSelectedIconImage: UIImage = #imageLiteral(resourceName: "briefing_selected")
    static let chatTabBarNormalIconImage: UIImage = #imageLiteral(resourceName: "chat_normal")
    static let chatTabBarSelectedIconImage: UIImage = #imageLiteral(resourceName: "chat_selelcted")
    static let nextIconImage: UIImage = UIImage(systemName: "chevron.forward")!
}
