//
//  UIView+Extension.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import UIKit
import SnapKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addShadow(offset: CGSize = CGSize(width: 0, height: 2),
                   color: UIColor = .black,
                   radius: CGFloat = 4,
                   opacity: Float = 0.2) {
        
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        
        // 성능 향상을 위해 그림자 경로 설정 (필요하면)
        // layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
}

