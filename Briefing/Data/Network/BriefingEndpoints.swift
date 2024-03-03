//
//  BriefingEndpoints.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct BriefingEndpoints {
    static func keyword(accessToken: String? = nil,
                        url: URL,
                        type: KeywordsType) ->
    BriefingEndpoint {
        BriefingEndpoint(
            accessToken,
            url: url,
            method: .get,
            path: .keywords,
            query: [.type: type.rawValue])
    }
    
    static func briefingCard(accessToken: String? = nil,
                             url: URL,
                             id: Int) -> BriefingEndpoint {
        return BriefingEndpoint(
            accessToken,
            url: url,
            method: .get,
            path: .briefingCard(id: id))
    }
}
