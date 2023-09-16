//
//  MainViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/16.
//

import UIKit
import FSCalendar

class MainViewController: UIViewController {
    var selectedDate = Date()
    
    private lazy var calendarView: FSCalendar = {
        let calendarView = FSCalendar()
        calendarView.scope = .week
        calendarView.headerHeight = .zero
        calendarView.weekdayHeight = .zero
        calendarView.appearance.weekdayTextColor = .blue
        calendarView.scrollDirection = .horizontal
        calendarView.pagingEnabled = false
        calendarView.select(selectedDate)
        calendarView.appearance.selectionColor = .white
        calendarView.appearance.todayColor = .clear
        calendarView.appearance.titleTodayColor = calendarView.appearance.titleDefaultColor
        
        // MARK: - 전체 날짜 선택 가능시 true
        calendarView.firstWeekday = UInt((7 + Date().dayOfWeek - 5)%7)
        calendarView.scrollEnabled = false
        return calendarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
    }
    
    private func configure() {
        self.view.backgroundColor = .briefingBlue
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
    }
    
    private func addSubviews() {
        let subViews: [UIView] = [calendarView]
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        let subViews: [UIView] = [calendarView]
        subViews.forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        let constraints: [NSLayoutConstraint] = [
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource, UICollectionViewDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // MARK: - 전체 날짜 선택 가능시 calendarScrollDateToCenter
        // calendarScrollDateToCenter(calendar, selectedDate: date)
        selectedDate = date
    }
    
    func calendarScrollDateToCenter(_ calendar: FSCalendar, selectedDate: Date) {
        guard let indexPath = calendar.collectionView.indexPathsForSelectedItems?.first else { return }
        let numOfDays = (indexPath.section * 7 + indexPath.row - 3)
        let section = Int(numOfDays / 7)
        let row = Int(numOfDays % 7)
        let newIndexPath = IndexPath(row: row, section: section)
        calendar.collectionView.scrollToItem(at: newIndexPath, at: .left, animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
}
