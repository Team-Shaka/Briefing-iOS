//
//  DateParser.swift
//  Briefing
//
//  Created by BoMin on 2023/08/24.
//

import Foundation

//extension Date {
//    func currentDateToYMD(date: Self) -> String {
//        let currentDate = Date()
//        let formatter = DateFormatter()
//
//        formatter.dateFormat = "yyyy-MM-dd"
//
//        let dateString = formatter.string(from: currentDate)
//
//        return dateString
//    }
//}

func currentDateToYMD() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd"
    
    let dateString = formatter.string(from: currentDate)
    
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

    dates.append("")
    dates.append("")
    

    let currentDate = Date()
    let targetDate = dateFormatter.date(from: "2023.08.27")!

    // 두 날짜 중 늦은 날짜를 기준으로 하여 7일간의 날짜를 구함
    let baseDate = max(currentDate, targetDate)

    // 다시 원래의 형식으로 설정
    dateFormatter.dateFormat = "yy.MM.dd"

    for i in -6...0 {
        if let date = Calendar.current.date(byAdding: .day, value: i, to: baseDate) {
            let formattedDate = dateFormatter.string(from: date)
            if date >= targetDate {
                dates.append(formattedDate)
            }
        }
    }

    // 두 개의 빈 문자열을 추가
    dates.append("")
    dates.append("")

    return dates
}

