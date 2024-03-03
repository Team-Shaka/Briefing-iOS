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
        guard let briefingViewController = pageViewController.viewControllers?.first
                as? HomeBriefingViewController else {
            return nil
        }
        let category = briefingViewController.category
        let index = (categories.firstIndex(of: category) ?? 0) - 1
        guard index >= 0 else { return nil }
        return pageChildViewControllers[safe: index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let briefingViewController = pageViewController.viewControllers?.first
                as? HomeBriefingViewController else {
            return nil
        }
        let category = briefingViewController.category
        let index = (categories.firstIndex(of: category) ?? 0) + 1
        guard index < pageChildViewControllers.count else { return nil }
        return pageChildViewControllers[safe: index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let selectedBriefingViewController = pageViewController.viewControllers?.first
                as? HomeBriefingViewController else {
            return
        }
        let category = selectedBriefingViewController.category
        let index = categories.firstIndex(of: category) ?? 0
        self.selectedCategoryRelay.accept(index)
    }
}
