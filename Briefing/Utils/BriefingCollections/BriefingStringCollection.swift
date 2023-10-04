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
    static let appDescription: String = NSLocalizedString("appDescription", comment: "")
    static let keywordBriefing: String = NSLocalizedString("keywordBriefing", comment: "")
    static let updated: String = NSLocalizedString("updated", comment: "")
    
    final class Format {
        private init() { }
        static let dateDotFormat = "yyyy.MM.dd";
        static let dateDashFormat = "yyyy-MM-dd";
        static let dateDetailDotFormat = "yyyy.MM.dd hha";
        static let dateDetailDashFormat = "yyyy-MM-dd hha";
    }
    
    final class Locale {
        static let ko = "ko_KR"
        static let en = "en_US"
    }
    
    enum Auth: String, EnumeratedLocalized {
        case signInWithApple
        case signInWithGoogle
    }
}
