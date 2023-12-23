//
//  String+.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/04.
//

import Foundation

extension String {
    func localize() -> String {
        NSLocalizedString((self.lowercased()), comment: "")
    }
    
    var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + self.dropFirst()
    }
    
    func toDate(dataFormat: String = "yyyy-MM-dd HH:mm:ss",
                localeIdentifier: String = "ko_KR") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dataFormat
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.timeZone = .current
        dateFormatter.date(from: self)
        return dateFormatter.date(from: self)
    }
}
