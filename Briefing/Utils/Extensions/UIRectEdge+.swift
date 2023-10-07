//
//  RadiusDirection.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import UIKit

extension UIRectEdge {
    var options: [CACornerMask] {
        switch self {
        case .top: return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom: return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .left: return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .right: return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .all: return [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                           .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default: return []
        }
    }
}
