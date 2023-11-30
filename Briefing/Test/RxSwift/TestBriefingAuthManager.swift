//
//  TestBriefingAuthManager.swift
//  Briefing
//
//  Created by 이전희 on 11/25/23.
//

import Foundation
import AuthenticationServices
import GoogleSignIn
import Alamofire
import RxSwift
import RxRelay

final class TestBriefingAuthManager: NSObject, BFNetworkManager {
    static let shared: TestBriefingAuthManager = TestBriefingAuthManager()
    private weak var presentationAnchorViewController: UIViewController?
    lazy var memberRelay = BehaviorRelay<(member: Member?, error: Error?)>(value: (member: member, error: nil))
    
    private var signInCompletion: ((_ member: Member?, _ error: Error?) -> Void)? = nil
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    var member: Member? {
        willSet(newValue) {
            memberRelay.accept((newValue, nil))
        }
    }
    
    private var appleSignInController: ASAuthorizationController {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = []
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        return controller
    }
    
    private override init() { }
    
    func signOut() -> Single<Member?> {
        member = nil
        return memberRelay
            .take(1)
            .asSingle()
            .map { (member, error) in
                if let error = error { throw error }
                return member
            }
    }
    
    func memberRelayToSingle() -> Single<Member?> {
        return memberRelay
            .skip(1)
            .take(1)
            .asSingle()
            .map { (member, error) in
                if let error = error { throw error }
                return member
            }
    }
}

extension TestBriefingAuthManager: ASAuthorizationControllerDelegate,
                               ASAuthorizationControllerPresentationContextProviding {
    func appleSignIn(withPresentation viewController: UIViewController) -> Single<Member?> {
        presentationAnchorViewController = viewController
        appleSignInController.performRequests()
        return memberRelayToSingle()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchorViewController?.view.window ?? UIWindow()
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        // if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
        //    let idTokenData = appleIDCredential.identityToken,
        //    let idToken = String(data: idTokenData, encoding: .utf8) {
        //     signIn(idToken: idToken, socialType: .apple)
        // } else {
        //     authorizationController(controller: controller,
        //                             didCompleteWithError: BriefingAuthError.wrongAccessError)
        // }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        // signInResultHandle(nil, error)
    }
}



// MARK: - Legacy Code
// MARK: - functions for Apple SignIn
extension TestBriefingAuthManager {
    func appleSignIn(withPresentation viewController: UIViewController,
                     completion: @escaping (_ member: Member?, _ error: Error?) -> Void) {
        signInCompletion = completion
        presentationAnchorViewController = viewController
        appleSignInController.performRequests()
    }
}

// MARK: - functions for Google SignIn
extension TestBriefingAuthManager {
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
private extension TestBriefingAuthManager {
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
extension TestBriefingAuthManager {
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

extension TestBriefingAuthManager {
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
extension TestBriefingAuthManager {
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
