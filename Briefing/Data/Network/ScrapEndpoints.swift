//
//  ScrapEndpoints.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct ScrapEndpoints {
    static func fetchScrap(accessToken: String,
                           url: URL,
                           memberId: Int) -> ScrapEndpoint {
        ScrapEndpoint(accessToken,
                      url: url,
                      method: .get,
                      path: .fetchScrap(memberId: memberId))
    }
    
    static func scrap(accessToken: String,
                      url: URL,
                      memberId: Int,
                      briefingId: Int) -> ScrapEndpoint {
        ScrapEndpoint(accessToken,
                      url: url,
                      method: .post,
                      path: .scrap,
                      httpBody: [.memberId: memberId,
                                 .briefingId: briefingId])
    }
    
    static func deleteScrap(accessToken: String,
                            url: URL,
                            memberId: Int,
                            briefingId: Int) -> ScrapEndpoint {
        ScrapEndpoint(accessToken,
                         url: url,
                         method: .delete,
                         path: .deleteScrap(id: briefingId,
                                            memberId: memberId))
    }
}
