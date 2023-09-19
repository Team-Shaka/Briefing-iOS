//
//  HomeViewController+FSCalendar.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/18.
//

import UIKit
import FSCalendar

extension HomeViewController: FSCalendarDelegate,
                              FSCalendarDataSource,
                              FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar,
                  didSelect date: Date,
                  at monthPosition: FSCalendarMonthPosition) {
        // MARK: - 전체 날짜 선택 가능시 calendarScrollDateToCenter
        // calendarScrollDateToCenter(calendar, selectedDate: date)
        changeSelectedDateAction(date)
    }
    
    func calendarScrollDateToCenter(_ calendar: FSCalendar,
                                    selectedDate: Date) {
        guard let indexPath = calendar.collectionView.indexPathsForSelectedItems?.first else { return }
        let numOfDays = (indexPath.section * 7 + indexPath.row - 3)
        let section = Int(numOfDays / 7)
        let row = Int(numOfDays % 7)
        let newIndexPath = IndexPath(row: row, section: section)
        calendar.collectionView.scrollToItem(at: newIndexPath, at: .left, animated: true)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        // MARK: - 전체 날짜 선택 가능시
        // return Date.date(year: 2000, month: 01, day: 01) ?? Date(timeIntervalSince1970: 0)
        return Date().date(byAdding: .day, value: -6) ?? Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().date(byAdding: .day, value: 1) ?? Date()
    }
    
    func calendar(_ calendar: FSCalendar,
                  shouldDeselect date: Date,
                  at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar,
                  cellFor date: Date,
                  at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell: HomeCalendarCell = calendar.dequeueReusableCell(withIdentifier: HomeCalendarCell.identifier,
                                                                        for: date,
                                                                        at: position) as? HomeCalendarCell else {
            return FSCalendarCell()
        }
        cell.setDate(date)
        cell.isUserInteractionEnabled = true
        return cell
    }
}
