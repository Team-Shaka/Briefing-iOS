//
//  HomeViewController+PageViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/18.
//

import UIKit

extension HomeViewController: UIPageViewControllerDelegate,
                              UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let briefingViewController = viewController as? HomeBriefingViewController,
              let date = briefingViewController.briefingDate.date(byAdding: .day, value: -1) else {
            return nil
        }
        guard date >= calendarView.minimumDate else { return nil }
        return HomeBriefingViewController(briefingDate: date)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let briefingViewController = viewController as? HomeBriefingViewController,
              let date = briefingViewController.briefingDate.date(byAdding: .day, value: 1) else {
            return nil
        }
        guard date < calendarView.maximumDate else { return nil }
        return HomeBriefingViewController(briefingDate: date)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let selectdBriefingViewController = pageViewController.viewControllers?.first
                as? HomeBriefingViewController else {
            return
        }
        self.changeSelectedDateAction(selectdBriefingViewController.briefingDate)
    }
}
