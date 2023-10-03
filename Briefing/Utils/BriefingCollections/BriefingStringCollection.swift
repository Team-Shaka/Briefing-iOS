//
//  BriefingStringCollection.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/18.
//

import Foundation

final class BriefingStringCollection {
    private init() { }
    
    static let appName: String = "Briefing"
    static let appDescription: String = "Your Keyword Newskeeper."
    static let keywordBriefing: String = "키워드 브리핑"
    static let updated: String = "Updated"
    
    final class Format {
        private init() { }
        static let dateDotFormat: String = "yyyy.MM.dd"
        static let dateDashFormat: String = "yyyy-MM-dd"
        static let dateDetailDotFormat: String = "yyyy.MM.dd hha"
        static let dateDetailDashFormat: String = "yyyy-MM-dd hha"
    }
    
    final class Locale {
        private init() { }
        static let ko: String = "ko_KR"
        static let en: String = "en_US"
    }
    
    final class Auth {
        private init() { }
        static let signInWithApple: String = "Log in with Apple"
        static let signInWithGoogle: String = "Log in with Google"
    }
}
