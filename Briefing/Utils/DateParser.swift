//
//  DateParser.swift
//  Briefing
//
//  Created by BoMin on 2023/08/24.
//

import Foundation

func isBefore3AM() -> Bool {
    let now = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.hour], from: now)
    if let hour = components.hour {
        return hour < 3
    }
    
    return false
}

func isTodaySlash(_ date: String) -> Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    if let selectedDate = formatter.date(from: date) {
        let today = Date()
        let calendar = Calendar.current
        return calendar.isDate(selectedDate, inSameDayAs: today)
    }
    return false
}

func isTodayDot(_ date: String) -> Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy.MM.dd"
    if let selectedDate = formatter.date(from: date) {
        let today = Date()
        let calendar = Calendar.current
        return calendar.isDate(selectedDate, inSameDayAs: today)
    }
    return false
}

func currentDateToYMD() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd"
    
    let dateString = formatter.string(from: currentDate)
    
    return dateString
}

func yesterdayDateToYMD() -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    
    guard let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate) else {
        return "날짜 계산 실패"
    }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    let dateString = formatter.string(from: yesterday)
    
    return dateString
}

func getCurrentDateinKor() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "yyyy년 M월 d일"
    
    let dateString = formatter.string(from: currentDate)
    
    return dateString
}

func getDateBeforeDaysinKor(_ days: Int) -> String {
    let currentDate = Date()
    var dateComponents = DateComponents()
    dateComponents.day = -days
    
    if let newDate = Calendar.current.date(byAdding: dateComponents, to: currentDate) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        
        let dateString = formatter.string(from: newDate)
        return dateString
    } else {
        return "날짜 계산에 실패했습니다."
    }
}

func getDateBeforeDaysinDash(_ days: Int) -> String {
    let currentDate = Date()
    var dateComponents = DateComponents()
    dateComponents.day = -days // 빼고자 하는 날짜만큼 음수로 설정
    
    if let newDate = Calendar.current.date(byAdding: dateComponents, to: currentDate) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: newDate)
        return dateString
    } else {
        return "날짜 계산에 실패했습니다."
    }
}


func slashToDot(slashDate: String) -> String {
    return slashDate.replacingOccurrences(of: "-", with: ".")
}

func slashToDotWithOutTime(date: String) -> String? {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    if let date = inputFormatter.date(from: date) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd"
        
        let outputString = outputFormatter.string(from: date)
        return outputString
    }
    return nil
}

func slashToDotAddTime(date: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    if let date = inputFormatter.date(from: date) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd ha"
        outputFormatter.locale = Locale(identifier: "en_US") // 로케일을 en_US로 설정
        
        let outputString = outputFormatter.string(from: date)
        return outputString
    }
    return nil
}


func dotToSlash(dotDate: String) -> String {
    return dotDate.replacingOccurrences(of: ".", with: "-")
}

func dotToSlashAdd20(dotDate: String) -> String {
    let slashedDate = dotDate.replacingOccurrences(of: ".", with: "-")
    return "20" + slashedDate
}

func dotToKorAdd20(dotDate: String) -> String? {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yy.MM.dd"
    
    if let date = inputFormatter.date(from: dotDate) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy년 M월 d일"
        
        let outputString = outputFormatter.string(from: date)
        return outputString
    }
    
    return nil
}


//func getLastWeekDates() -> [String] {
//    var dates: [String] = []
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yy.MM.dd"
//
//    dates.append("")
//    dates.append("")
//
//    for i in -6...0 {
//        if let date = Calendar.current.date(byAdding: .day, value: i, to: Date()) {
//            let formattedDate = dateFormatter.string(from: date)
//            dates.append(formattedDate)
//        }
//    }
//
//    // 두 개의 빈 문자열을 추가
//    dates.append("")
//    dates.append("")
//
//    return dates
//}

func getLastWeekDates() -> [String] {
    var dates: [String] = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"

    let currentDate = Date()
    let targetDate = dateFormatter.date(from: "2023.08.27")!

    let baseDate = max(currentDate, targetDate)

    dateFormatter.dateFormat = "yy.MM.dd"

    for i in -6...0 {
        if let date = Calendar.current.date(byAdding: .day, value: i, to: baseDate) {
            let formattedDate = dateFormatter.string(from: date)
            if date >= targetDate {
                dates.append(formattedDate)
            }
        }
    }
    
    return dates
}

func getLastWeekDatesFromYesterday() -> [String] {
    var dates: [String] = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"

    let currentDate = Date()
    let targetDate = dateFormatter.date(from: "2023.08.27")!

    // 어제의 날짜를 계산합니다.
    guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else {
        return ["날짜 계산 실패"] // 더 정확한 에러 처리가 필요할 수 있습니다.
    }

    let baseDate = max(yesterday, targetDate)

    dateFormatter.dateFormat = "yy.MM.dd"

    for i in -6...0 {
        if let date = Calendar.current.date(byAdding: .day, value: i, to: baseDate) {
            let formattedDate = dateFormatter.string(from: date)
            if date >= targetDate {
                dates.append(formattedDate)
            }
        }
    }
    
    return dates
}
