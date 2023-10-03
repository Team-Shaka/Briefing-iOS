//
//  UITabBarController.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import UIKit

class MainTabBarController: UITabBarController {
    let tabBarItemViewControllers: [TabBarItemViewController] = [
        HomeViewController(),
        ChatsViewController()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBarController?.tabBar.isHidden = false
        setTabBarItemViewControllers()
        configure()
    }
    
    private func setTabBarItemViewControllers(){
        let viewControllers = tabBarItemViewControllers.enumerated().compactMap { idx, tabBarItemViewController in
            let tabBarItem =  UITabBarItem(title: nil,
                                           image: tabBarItemViewController.tabBarIcon,
                                           tag: idx)
            tabBarItem.selectedImage = tabBarItemViewController.tabBarSelectedIcon
            tabBarItemViewController.tabBarItem = tabBarItem
            return tabBarItemViewController as UIViewController
        }
        
        self.viewControllers = viewControllers
    }
    
    private func configure() {
        self.selectedIndex = 0
        self.tabBar.backgroundColor = .mainGray
        self.tabBar.tintColor = .mainBlue
    }
}
