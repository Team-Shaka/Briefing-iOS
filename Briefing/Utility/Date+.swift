//
//  Date+.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/16.
//

import Foundation

extension Date {
    /// dayOfWeek
    /// sun: 0, mon: 1, ....
    var dayOfWeek: Int {
        Calendar.current.component(.weekday, from: self) - 1
    }
}
