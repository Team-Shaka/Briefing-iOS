//
//  String+.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/04.
//

import Foundation

extension String {
    var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + self.dropFirst()
    }
}
