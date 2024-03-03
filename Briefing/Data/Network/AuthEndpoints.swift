//
//  AuthEndpoints.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

struct AuthEndpoints {
    static func signIn(url: URL,
                       socialType: SocialType,
                       idToken: String) -> AuthEndpoint {
        AuthEndpoint(url: url,
                     method: .post,
                     path: .signIn(socialType),
                     httpBody: [.idToken: idToken])
    }
    
    static func refreshToken(accessToken: String,
                             url: URL,
                             refreshToken: String) -> AuthEndpoint {
        AuthEndpoint(accessToken,
                     url: url,
                     method: .post,
                     path: .refresh,
                     httpBody: [.refreshToken: refreshToken])
    }
    
    static func withdrawal(accessToken: String,
                           url: URL,
                           memberId: Int) -> AuthEndpoint {
        AuthEndpoint(accessToken,
                     url: url,
                     method: .delete,
                     path: .withdrawal(memberId))
    }
}
