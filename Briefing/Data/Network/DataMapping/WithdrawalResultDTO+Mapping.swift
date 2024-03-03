//
//  WithdrawalResultDTO+Mapping.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct WithdrawalResultDTO: Codable {
    let quitAt: String
}

extension WithdrawalResultDTO {
    func toDomain() -> WithdrawalResult {
        WithdrawalResult(isSuccess: true)
    }
}
