//
//  TabBarItemViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/18.
//

import UIKit

protocol TabBarItemViewController where Self: UIViewController {
    var tabBarIcon: UIImage { get }
    var tabBarSelectedIcon: UIImage { get }
}
