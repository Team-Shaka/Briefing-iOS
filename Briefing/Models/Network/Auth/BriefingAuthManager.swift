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
    weak var presentationAnchorViewController: UIViewController?
    private var signInCompletion: ((_ member: Member?, _ error: Error?) -> Void)? = nil
    
    var appleSignInController: ASAuthorizationController {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = []
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        return controller
    }
    
    private override init() { }
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
           let idToken = String(data: idTokenData, encoding: .utf8){
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
    
    func googleRefreshTokensIfNeeded(user: GIDGoogleUser?){
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
        guard let urlRequest = BriefingAuthURLRequest(url: url,
                                                      method: .post,
                                                      path: .signIn(socialType),
                                                      httpBody: [.idToken: idToken]) else {
            signInResultHandle(nil, BriefingAuthError.wrongURLReqeustError)
            return
        }
        
        response(urlRequest,
                 type: Member.self) { value, error in
            self.signInResultHandle(value, error)
        }
    }
    
    func signInResultHandle(_ member: Member?, _ error: Error?){
        signInCompletion?(member, error)
        signInCompletion = nil
    }
}
