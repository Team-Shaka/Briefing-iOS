//
//  UIView+.swift
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
    
    func setGradient(color1: UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0 , 1.0]

        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)  // 상단 시작
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)    // 하단 끝

        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    func blinkBackgroundColor(color: UIColor, duration: TimeInterval) {
        let originalColor = self.backgroundColor
        
        UIView.animate(withDuration: duration / 2, animations: {
            self.backgroundColor = color
        }) { (finished) in
            if finished {
                UIView.animate(withDuration: duration / 2) {
                    self.backgroundColor = originalColor
                }
            }
        }
    }
    
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
