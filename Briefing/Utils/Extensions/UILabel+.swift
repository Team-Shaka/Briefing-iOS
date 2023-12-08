//
//  UILabel+.swift
//  Briefing
//
//  Created by BoMin Lee on 11/30/23.
//

import UIKit

extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    func asFont(targetString: String, font: UIFont) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedText = attributedString
    }
    
//    func asFontColor(targetString: String, font: UIFont?, color: UIColor?) {
//        let fullText = text ?? ""
//        let attributedString = NSMutableAttributedString(string: fullText)
//        let range = (fullText as NSString).range(of: targetString)
//        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
//        attributedText = attributedString
//    }
    
    func applyStyles(to targetStrings: [(string: String, font: UIFont?, color: UIColor?)]) {
        guard let fullText = text else { return }

        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(.font, value: self.font as Any, range: NSRange(location: 0, length: fullText.utf16.count))
        attributedString.addAttribute(.foregroundColor, value: self.textColor as Any, range: NSRange(location: 0, length: fullText.utf16.count))

        for target in targetStrings {
            let range = (fullText as NSString).range(of: target.string)
            if let font = target.font {
                attributedString.addAttribute(.font, value: font, range: range)
            }
            if let color = target.color {
                attributedString.addAttribute(.foregroundColor, value: color, range: range)
            }
        }

        attributedText = attributedString
    }

}

