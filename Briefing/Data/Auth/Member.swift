//
//  Member.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import Foundation

struct Member: Codable {
    let memberId: Int
    let accessToken: String
    let refreshToken: String
}
