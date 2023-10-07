//
//  BriefingNavigationBarItem.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import UIKit

class BriefingBackBarButtonItem: UIBarButtonItem {
    convenience override init() {
        let imageView = UIImageView()
        imageView.image = BriefingImageCollection.nextIconImage
        imageView.tintColor = .briefingNavy
        imageView.contentMode = .scaleAspectFit
        self.init(customView: imageView)
    }
}
