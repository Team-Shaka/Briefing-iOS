//
//  BriefingAuthManager.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/02.
//

import Foundation
import GoogleSignIn

final class BriefingAuthManager {
    static let shared: BriefingAuthManager = BriefingAuthManager()
    private init() { }
    
}

extension BriefingAuthManager {
    func googleSignIn(withPresenting viewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            print("🍎 \(signInResult) \(error)")
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }

            signInResult.user.refreshTokensIfNeeded { user, error in
                guard error == nil else { return }
                guard let user = user else { return }

                let idToken = user.idToken
                print(idToken)
            }
        }
    }
    
    func appleSignIn() {
        
    }
}
