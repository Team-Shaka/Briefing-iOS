//
//  Array+.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
