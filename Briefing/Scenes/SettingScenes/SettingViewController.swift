//
//  SettingViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/05.
//

import UIKit

enum SettingTableViewCellType {
    case `default`(symbol: UIImage, title: String, subTitle: String?=nil, urlString: String?=nil)
    case button(title: String, color: UIColor)
}

class SettingViewController: UIViewController {
    let cellData: [[SettingTableViewCellType]] = [
        [],
        [
         //    .default(symbol: BriefingImageCollection.Setting.appVersion,
         //             title: BriefingStringCollection.Setting.appVersionTitle.localized,
         //             subTitle: BriefingStringCollection.appVersion),
         // .default(symbol: BriefingImageCollection.Setting.feedback,
         //          title: BriefingStringCollection.Setting.feedbackAndInquiry.localized,
         //          urlString: ""),
         // .default(symbol: <#T##UIImage#>, title: , urlString: <#T##String?#>),
         // .default(symbol: <#T##UIImage#>, title: , urlString: <#T##String?#>),
        ]
    ]
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
    }
    
    private func configure() {
        
    }
    
    private func addSubviews() {
        let subViews: [UIView] = [tableView]
        
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        
    }
    
}
