//
//  Font+.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/17.
//

import SwiftUI

extension Font {
    enum FontWeight: String {
        case bold
        case regular
        case italic
        case boldItalic = "bold-Italic"
        
        var value: String {
            self.rawValue.capitalized
        }
    }
    
    static func productSans(size:CGFloat, weight: FontWeight = .regular) -> Font {
        return Font.custom("ProductSans-\(weight.value)", size: size)
    }
}
