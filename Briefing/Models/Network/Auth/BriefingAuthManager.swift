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
    func appleSignIn(withPresentation viewController: UIViewController){
        presentationAnchorViewController = viewController
        appleSignInController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchorViewController?.view.window ?? UIWindow()
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let identityToken = appleIDCredential.identityToken
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        print(error)
    }
}

// MARK: - functions for Google SignIn
extension BriefingAuthManager {
    func googleSignIn(withPresentation viewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            signInResult.user.refreshTokensIfNeeded { user, error in
                guard error == nil else { return }
                guard let user = user else { return }
                let idToken = user.idToken?.tokenString
            }
        }
    }
}

// MARK: - SignIn with Briefing Server
extension BriefingAuthManager {
    func signIn(idToken: String,
                socialType: BriefingAuthURLRequest.SocialType) {
        let url = BriefingURLManager.url(key: .baseUrl)
        
        // guard let urlRequest = BriefingAuthURLRequest(urlRequest: <#T##URLRequest#>,
        //                                               method: .post,
        //                                               path: <#T##BriefingAuthURLRequest.Path#>,
        //                                               httpBody: <#T##String?#>,
        //                                               query: <#T##[BriefingAuthURLRequest.QueryKey : String]?#>)
        
        // response(<#T##briefingURLRequest: BriefingNetworkURLRequest##BriefingNetworkURLRequest#>,
        //          type: <#T##(Decodable & Encodable).Protocol#>,
        //          completion: <#T##((Decodable & Encodable)?, Error?) -> Void##((Decodable & Encodable)?, Error?) -> Void##(_ value: (Decodable & Encodable)?, _ error: Error?) -> Void#>)
    }
}
