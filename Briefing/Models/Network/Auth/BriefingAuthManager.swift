//
//  BriefingAuthManager.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/02.
//

import Foundation
import AuthenticationServices
import GoogleSignIn
import Alamofire

final class BriefingAuthManager: NSObject, BFNetworkManager {
    static let shared: BriefingAuthManager = BriefingAuthManager()
    private weak var presentationAnchorViewController: UIViewController?
    private var signInCompletion: ((_ member: Member?, _ error: Error?) -> Void)? = nil
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    var member: Member?
    
    private var appleSignInController: ASAuthorizationController {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = []
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        return controller
    }
    
    private override init() { }
    
    func signOut() {
        member = nil
    }
}

// MARK: - functions for Apple SignIn
extension BriefingAuthManager: ASAuthorizationControllerDelegate,
                               ASAuthorizationControllerPresentationContextProviding {
    func appleSignIn(withPresentation viewController: UIViewController,
                     completion: @escaping (_ member: Member?, _ error: Error?) -> Void) {
        signInCompletion = completion
        presentationAnchorViewController = viewController
        appleSignInController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchorViewController?.view.window ?? UIWindow()
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
           let idTokenData = appleIDCredential.identityToken,
           let idToken = String(data: idTokenData, encoding: .utf8) {
            signIn(idToken: idToken, socialType: .apple)
        } else {
            authorizationController(controller: controller,
                                    didCompleteWithError: BriefingAuthError.wrongAccessError)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        signInResultHandle(nil, error)
    }
}

// MARK: - functions for Google SignIn
extension BriefingAuthManager {
    func googleSignIn(withPresentation viewController: UIViewController,
                      completion: @escaping (_ member: Member?, _ error: Error?) -> Void) {
        signInCompletion = completion
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            do {
                if let error = error { throw error }
                guard let googleUser = signInResult?.user else { throw BriefingAuthError.noDataError }
                self.googleRefreshTokensIfNeeded(user: googleUser)
                
            } catch {
                self.signInResultHandle(nil, error)
            }
        }
    }
    
    private func googleRefreshTokensIfNeeded(user: GIDGoogleUser?){
        user?.refreshTokensIfNeeded { user, error in
            do {
                if let error = error { throw error }
                guard let idToken = user?.idToken?.tokenString else {
                    throw BriefingAuthError.noDataError
                }
                self.signIn(idToken: idToken, socialType: .google)
            }
            catch {
                self.signInResultHandle(nil, error)
            }
        }
    }
}

// MARK: - SignIn with Briefing Server
private extension BriefingAuthManager {
    func signIn(idToken: String,
                socialType: BriefingAuthURLRequest.SocialType) {
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let urlRequest = BriefingAuthURLRequest(member?.accessToken,
                                                      url: url,
                                                      method: .post,
                                                      path: .signIn(socialType),
                                                      httpBody: [.idToken: idToken]) else {
            signInResultHandle(nil, BriefingAuthError.wrongURLReqeustError)
            return
        }
        
        response(urlRequest,
                 type: Member.self) { member, error in
            self.signInResultHandle(member, error)
        }
    }
    
    func signInResultHandle(_ member: Member?, _ error: Error?){
        if let member = member {
            self.member = member
        }
        signInCompletion?(member, error)
        signInCompletion = nil
    }
}

// MARK: - Refresh Token
extension BriefingAuthManager {
    func refreshToken(_ completion: ((_ isMember: Bool, _ member: Member?, _ error: Error?) -> Void)?) {
        guard let member = member else {
            completion?(false, nil, nil)
            return
        }
        
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let urlRequest = BriefingAuthURLRequest(member.accessToken,
                                                      url: url,
                                                      method: .post,
                                                      path: .refresh,
                                                      httpBody: [.refreshToken: member.refreshToken]) else {
            completion?(true, nil, BriefingAuthError.wrongURLReqeustError)
            return
        }
        
        response(urlRequest,
                 type: Member.self) { member, error in
            if let member = member {
                self.member = member
            }
            completion?(true, member, error)
        }
    }
}

extension BriefingAuthManager {
    func withdrawal(_ completion: ((_ withdrawalResult: WithdrawalResult?,
                                    _ error: Error?) -> Void)?) {
        guard let memberId = BriefingAuthManager.shared.member?.memberId else {
            completion?(nil, BriefingNetworkError.noAuthError)
            return
        }
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let urlRequest = BriefingAuthURLRequest(member?.accessToken,
                                                      url: url,
                                                      method: .delete,
                                                      path: .withdrawal(memberId)) else {
            completion?(nil, BriefingAuthError.wrongURLReqeustError)
            return
        }

        response(urlRequest,
                 type: WithdrawalResult.self) { result, error in
            if let _ = result {
                self.member = nil
            }
            completion?(result, error)
        }
    }
}

// MARK: Test Token
extension BriefingAuthManager {
    func testToken(_ completion: ((_ member: Member?, _ error: Error?) -> Void)?) {
        let url = BriefingURLManager.url(key: .baseUrl)
        guard let urlRequest = BriefingAuthURLRequest(member?.accessToken,
                                                      url: url,
                                                      method: .get,
                                                      path: .test) else {
            completion?(nil, BriefingAuthError.wrongURLReqeustError)
            return
        }
        
        response(urlRequest,
                 type: Member.self) { testMember, error in
            completion?(testMember, error)
        }
    }
}
