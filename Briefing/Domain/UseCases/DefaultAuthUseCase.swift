//
//  DefaultAuthUseCase.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation
import RxSwift

final class DefaultAuthUseCase {
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    func isSignedIn() -> Bool {
        authRepository.isSignedIn()
    }
    
    func signIn(idToken: String,
                socialType: SocialType) -> Single<Bool> {
        authRepository.signIn(idToken: idToken,
                              socialType: socialType)
    }
    
    func signOut() -> Single<Bool> {
        authRepository.signOut()
    }
    
    func refreshToken() -> Single<Bool> {
        authRepository.refreshToken()
    }
    
    func withdrawal() -> Single<WithdrawalResult> {
        authRepository.withdrawal()
    }
}
