//
//  BriefingAuthManager.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/02.
//

import Foundation
import AuthenticationServices
import RxSwift

final class DefaultAuthRepository: NSObject, BFNetworkService {
    private let baseUrl = BriefingURLContainer.url(key: .baseUrl)
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    private var member: Member?
}

extension DefaultAuthRepository: AuthRepository {
    func isSignedIn() -> Bool {
        self.member != nil
    }
    
    func signIn(idToken: String,
                socialType: SocialType) -> Single<Bool> {
        let endpoint = AuthEndpoints.signIn(url: baseUrl,
                                            socialType: socialType,
                                            idToken: idToken)
        
        return response(endpoint,
                        type: Member.self)
        .do { member in
            self.member = member
        }
        .map { _ in true }
    }
    
    func signOut() -> Single<Bool> {
        Single.create { promise in
            promise(.success(true))
            return Disposables.create()
        }
    }
    
    func refreshToken() -> Single<Bool> {
        guard let member = member else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        
        let endpoint = AuthEndpoints.refreshToken(accessToken: member.accessToken,
                                                  url: baseUrl,
                                                  refreshToken: member.refreshToken)
        
        return response(endpoint,
                        type: Member.self)
        .do(onSuccess: { member in
            self.member = member
        })
        .map { _ in true }
    }
    
    func withdrawal() -> Single<WithdrawalResult> {
        guard let member = member else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        
        let endpoint = AuthEndpoints.withdrawal(accessToken: member.accessToken,
                                                url: baseUrl,
                                                memberId: member.memberId)
        return response(endpoint,
                        type: WithdrawalResultDTO.self)
        .map { $0.toDomain() }
        .do(onSuccess: { _ in
            self.member = nil
        })
    }
}
