//
//  AuthUseCase.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation
import RxSwift

protocol AuthUseCase {
    func isSignedIn() -> Bool
    func signIn(idToken: String,
                socialType: SocialType) -> Single<Bool>
    func signOut() -> Single<Bool>
    func refreshToken() -> Single<Bool>
    func withdrawal() -> Single<WithdrawalResult>
}
