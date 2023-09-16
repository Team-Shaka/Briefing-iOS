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
    
    private var calendarGuideView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private var pageViewController: UIPageViewController {
        let pageViewController = UIPageViewController()
        return pageViewController
    }
    
    private lazy var calendarView: FSCalendar = {
        let calendarView = FSCalendar()
        calendarView.scope = .week
        calendarView.headerHeight = .zero
        calendarView.weekdayHeight = .zero
        calendarView.appearance.weekdayTextColor = .blue
        calendarView.scrollDirection = .horizontal
        calendarView.pagingEnabled = false
        calendarView.select(selectedDate)
        calendarView.today = nil
        calendarView.appearance.selectionColor = .clear
        
        calendarView.firstWeekday = UInt((7 + Date().dayOfWeek - 5)%7)
        // MARK: - 전체 날짜 선택 가능시 true
        calendarView.scrollEnabled = false
        return calendarView
    }()
    
    var calendarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
    }
    
    private func configure() {
        view.backgroundColor = .briefingBlue
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(MainCalendarCell.self,
                              forCellReuseIdentifier: MainCalendarCell.identifier)
        
    }
    
    private func addSubviews() {
        calendarGuideView.addSubview(calendarView)
        
        let subViews: [UIView] = [calendarGuideView]
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        calendarGuideView.snp.makeConstraints { make in
            make.top.centerX.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(6)
            make.height.equalTo(80)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(calendarGuideView)
            make.bottom.equalTo(view)
        }
        
    }
    
    func changeSelectedDateAction(_ date: Date) {
        selectedDate = date
    }
}

extension MainViewController: FSCalendarDelegate,
                              FSCalendarDataSource,
                              FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // MARK: - 전체 날짜 선택 가능시 calendarScrollDateToCenter
        // calendarScrollDateToCenter(calendar, selectedDate: date)
        changeSelectedDateAction(date)
    }
    
    func calendarScrollDateToCenter(_ calendar: FSCalendar, selectedDate: Date) {
        guard let indexPath = calendar.collectionView.indexPathsForSelectedItems?.first else { return }
        let numOfDays = (indexPath.section * 7 + indexPath.row - 3)
        let section = Int(numOfDays / 7)
        let row = Int(numOfDays % 7)
        let newIndexPath = IndexPath(row: row, section: section)
        calendar.collectionView.scrollToItem(at: newIndexPath, at: .left, animated: true)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date.date(year: 2000, month: 01, day: 01) ?? Date(timeIntervalSince1970: 0)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell: MainCalendarCell = calendar.dequeueReusableCell(withIdentifier: MainCalendarCell.identifier,
                                                                        for: date,
                                                                        at: position) as? MainCalendarCell else {
            return FSCalendarCell()
        }
        cell.setDate(date)
        cell.isUserInteractionEnabled = true
        return cell
    }
}
