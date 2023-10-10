//
//  UIButton.Configuration+.swift
//  Briefing
//
//  Created by 이전희 on 10/10/23.
//

import UIKit

extension UIButton.Configuration {
    static func BriefingButtonConfiguration(image: UIImage? = nil,
                                            title: String,
                                            foregroundColor: UIColor = .white,
                                            backgroundColor: UIColor = .black,
                                            font: UIFont = .productSans(size: 16, weight: .bold),
                                            imagePadding:CGFloat = 10,
                                            cornerRadius: CGFloat = 26) -> UIButton.Configuration {
        var container = AttributeContainer()
        container.font = font
        container.foregroundColor = foregroundColor
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = backgroundColor
        configuration.titleAlignment = .center
        configuration.imagePadding = imagePadding
        configuration.background.cornerRadius = cornerRadius
        configuration.attributedTitle = AttributedString(title,
                                                         attributes: container)
        configuration.image = image
        configuration.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        return configuration
    }
}
