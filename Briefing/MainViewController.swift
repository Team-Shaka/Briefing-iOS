//
//  MainViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/16.
//

import UIKit
import FSCalendar

final class MainViewController: UIViewController {
    var selectedDate = Date()
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UIView = {
        let label = UILabel()
        label.text = "Briefing"
        label.font = .productSans(size: 24)
        label.textColor = .briefingWhite
        return label
    }()
    
    private var storageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "storage"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "setting"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var calendarGuideView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
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
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal)
        
        return pageViewController
    }()
    
    private var briefingViewControllers: [UIViewController] = {
        let today = Date()
        return [
            MainBriefingViewController(briefingDate: today.date(byAdding: .day, value: -6) ?? today),
            MainBriefingViewController(briefingDate: today.date(byAdding: .day, value: -5) ?? today),
            MainBriefingViewController(briefingDate: today.date(byAdding: .day, value: -4) ?? today),
            MainBriefingViewController(briefingDate: today.date(byAdding: .day, value: -3) ?? today),
            MainBriefingViewController(briefingDate: today.date(byAdding: .day, value: -2) ?? today),
            MainBriefingViewController(briefingDate: today.date(byAdding: .day, value: -1) ?? today),
            MainBriefingViewController(briefingDate: today)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
    }
    
    private func configure() {
        view.backgroundColor = .briefingBlue
        navigationItem.title = "Briefing"
        navigationController?.isNavigationBarHidden = true
        
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(MainCalendarCell.self,
                              forCellReuseIdentifier: MainCalendarCell.identifier)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        if let currentBriefingViewController = briefingViewControllers.last {
            pageViewController.setViewControllers([currentBriefingViewController],
                                                  direction: .forward,
                                                  animated: true)
        }
    }
    
    private func addSubviews() {
        calendarGuideView.addSubview(calendarView)
        
        let navigationSubviews: [UIView] = [titleLabel,
                                            storageButton,
                                            settingButton]
        navigationSubviews.forEach { subView in
            navigationView.addSubview(subView)
        }
        
        let subViews: [UIView] = [navigationView,
                                  calendarGuideView,
                                  pageViewController.view]
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(titleLabel).offset(6)
            make.leading.trailing.equalTo(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView).offset(6)
            make.centerY.equalTo(navigationView)
            make.leading.equalTo(navigationView).inset(28)
            make.trailing.lessThanOrEqualTo(storageButton)
        }
        
        storageButton.snp.makeConstraints { make in
            make.height.equalTo(navigationView)
            make.width.equalTo(storageButton.snp.height)
            make.trailing.equalTo(settingButton.snp.leading).offset(-2)
            make.centerY.equalTo(navigationView)
        }
        
        settingButton.snp.makeConstraints { make in
            make.height.equalTo(navigationView)
            make.width.equalTo(settingButton.snp.height)
            make.trailing.equalTo(navigationView).inset(18)
            make.centerY.equalTo(navigationView)
        }
        
        calendarGuideView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(6)
            make.height.equalTo(80)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(calendarGuideView)
            make.bottom.equalTo(view)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(calendarGuideView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
    // FIXME: - PageViewController & Calendar Sync
    func changeSelectedDateAction(_ date: Date) {
        selectedDate = date
        if calendarView.selectedDate != selectedDate {
            calendarView.select(selectedDate)
        }
        if let viewController = pageViewController.viewControllers?.first,
           let breifingViewController = viewController as? MainBriefingViewController {
            
            if breifingViewController.briefingDate != selectedDate,
               let currentBreifingViewController = briefingViewControllers.filter({ vc in
                   print(vc, selectedDate)
                   return (vc as? MainBriefingViewController)?.briefingDate == selectedDate
               }).first {
                let direction: UIPageViewController.NavigationDirection = breifingViewController.briefingDate > selectedDate ? .reverse : .forward
                pageViewController.setViewControllers([currentBreifingViewController],
                                                      direction: direction,
                                                      animated: true)
            }
        }
    }
}

extension MainViewController: FSCalendarDelegate,
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
        return Date.date(year: 2000, month: 01, day: 01) ?? Date(timeIntervalSince1970: 0)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar,
                  shouldDeselect date: Date,
                  at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar,
                  cellFor date: Date,
                  at position: FSCalendarMonthPosition) -> FSCalendarCell {
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

extension MainViewController: UIPageViewControllerDelegate,
                              UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = briefingViewControllers.firstIndex(of: viewController),
              let viewController = briefingViewControllers[safe: index - 1] else { return nil }
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = briefingViewControllers.firstIndex(of: viewController),
              let viewController = briefingViewControllers[safe: index - 1] else { return nil }
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let selectdBriefingViewController = pageViewController.viewControllers?.first
                as? MainBriefingViewController else {
            return
        }
        self.changeSelectedDateAction(selectdBriefingViewController.briefingDate)
    }
}
