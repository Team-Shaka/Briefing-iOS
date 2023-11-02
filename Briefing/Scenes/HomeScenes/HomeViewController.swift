//
//  HomeViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/16.
//

import UIKit
import FSCalendar

final class HomeViewController: UIViewController, TabBarItemViewController {
    let tabBarIcon: UIImage = BriefingImageCollection.briefingTabBarNormalIconImage
    let tabBarSelectedIcon: UIImage = BriefingImageCollection.briefingTabBarSelectedIconImage
    var selectedDate = Date().midnight
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UIView = {
        let label = UILabel()
        label.text = BriefingStringCollection.appName
        label.font = .productSans(size: 24)
        label.textColor = .briefingWhite
        return label
    }()
    
    private lazy var scrapButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.scrapImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showScrapViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.settingImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showSettingViewController), for: .touchUpInside)
        return button
    }()
    
    private var calendarGuideView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    lazy var calendarView: FSCalendar = {
        let calendarView = FSCalendar()
        calendarView.locale = .current
        calendarView.scope = .week
        calendarView.headerHeight = .zero
        calendarView.weekdayHeight = .zero
        calendarView.appearance.weekdayTextColor = .blue
        calendarView.scrollDirection = .horizontal
        calendarView.pagingEnabled = false
        calendarView.select(selectedDate)
        calendarView.today = nil
        calendarView.appearance.selectionColor = .clear
        calendarView.allowsMultipleSelection = false
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configure() {
        view.backgroundColor = .briefingBlue
        navigationItem.title = BriefingStringCollection.appName
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(HomeCalendarCell.self,
                              forCellReuseIdentifier: HomeCalendarCell.identifier)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.setViewControllers([HomeBriefingViewController(briefingDate: selectedDate)],
                                              direction: .forward,
                                              animated: true)
    }
    
    private func addSubviews() {
        calendarGuideView.addSubview(calendarView)
        
        let navigationSubviews: [UIView] = [titleLabel,
                                            scrapButton,
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
            make.trailing.lessThanOrEqualTo(scrapButton)
        }
        
        scrapButton.snp.makeConstraints { make in
            make.height.equalTo(navigationView)
            make.width.equalTo(scrapButton.snp.height)
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
    
    @objc func showScrapViewController() {
        self.navigationController?.pushViewController(ScrapbookViewController(), animated: true)
    }
    
    @objc func showSettingViewController() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    // FIXME: - PageViewController & Calendar Sync
    func changeSelectedDateAction(_ date: Date) {
        self.selectedDate = date
        if let prevSelectedDate = calendarView.selectedDate,
           prevSelectedDate != date {
            calendarView.cell(for: prevSelectedDate, at: .current)?.isSelected = false
            calendarView.select(selectedDate)
        }
        if let prevSelectedViewDate = (pageViewController.viewControllers?.first
                               as? HomeBriefingViewController)?.briefingDate {
            let direction: UIPageViewController.NavigationDirection = date > prevSelectedViewDate ? .forward : .reverse
            if prevSelectedViewDate != date {
                pageViewController.setViewControllers([HomeBriefingViewController(briefingDate: date)],
                                                      direction: direction,
                                                      animated: true)
            }
        }
    }
}
