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
    
    var midnight: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                  from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(from: components)!
    }
    
    var dateToIntSet: (year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return (year: year, month: month, day: day)
    }
    static func date(_ dateStr: String, dateFormat: String="yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: dateStr)
    }
    
    static func date(year: Int, month: Int, day: Int) -> Date? {
        let dateStr = "\(year)-\(month)-\(day)"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateStr)
    }
    
    func date(byAdding: Calendar.Component, value: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: byAdding, value: value, to: self)
    }

    func dateToString(_ dateFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
