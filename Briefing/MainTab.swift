//
//  MainTab.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import UIKit

class MainTab: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBarController?.tabBar.isHidden = false
        setView()
    }
    
    private func setView() {
        let first = UINavigationController(rootViewController: BriefingTab())
        let firstItem = UITabBarItem(title: nil, image: UIImage(named: "briefing_normal"), tag: 1)
        
        first.tabBarItem = firstItem
        first.tabBarItem.selectedImage = UIImage(named: "briefing_selected")
        
        let second = UINavigationController(rootViewController: ChatsTab())
        let secondItem = UITabBarItem(title: nil, image: UIImage(named: "chat_normal"), tag: 2)
        
        second.tabBarItem = secondItem
        second.tabBarItem.selectedImage = UIImage(named: "chat_selected")
        
        self.viewControllers = [first, second]
        self.selectedIndex = 0
        
        self.tabBar.backgroundColor = .mainGray
        self.tabBar.tintColor = .mainBlue
        
//        self.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
    }
}
