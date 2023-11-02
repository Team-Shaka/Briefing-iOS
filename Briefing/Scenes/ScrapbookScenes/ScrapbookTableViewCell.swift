//
//  ScrapbookTableViewCell.swift
//  Briefing
//
//  Created by BoMin Lee on 11/2/23.
//

import UIKit

class ScrapbookTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: ScrapbookTableViewCell.self)
    
    private var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
}
