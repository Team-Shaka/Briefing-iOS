//
//  SignInViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/17.
//

import UIKit
import SnapKit
import AuthenticationServices
import GoogleSignIn
import RxSwift

class SignInViewController: UIViewController {
    private let authUseCase = AppDIContainer.shared.authUseCase
    private let disposeBag = DisposeBag()
    
    private var appleSignInController: ASAuthorizationController {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = []
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        return controller
    }
    
    private var briefingMainContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private var briefingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.appName
        label.textColor = .white
        label.textAlignment = .center
        label.font = .productSans(size: 70, weight: .bold)
        return label
    }()
    
    private var briefingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.appDescription
        label.font = .productSans(size: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var briefingChatGPTImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = BriefingImageCollection.chatGPTImage
        return imageView
    }()
    
    private var signInButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 22
        return stackView
    }()
    
    private lazy var appleSignInButton: UIButton = {
        let configuration = UIButton.Configuration
            .BriefingButtonConfiguration(image: BriefingImageCollection.appleLogo,
                                         title: BriefingStringCollection.Auth.signInWithApple.localized)
        return UIButton(configuration: configuration)
    }()
    
    private lazy var googleSignInButon: UIButton = {
        let configuration = UIButton.Configuration
            .BriefingButtonConfiguration(image: BriefingImageCollection.googleLogo,
                                         title: BriefingStringCollection.Auth.signInWithGoogle.localized,
                                         foregroundColor: .googleGray,
                                         backgroundColor: .white)
        return UIButton(configuration: configuration)
    }()
    
    private var signInButtonDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .briefingLightBlue
        return view
    }()
    
    private var signInLaterButton: UIButton = {
        let button = UIButton()
        button.setTitle(BriefingStringCollection.Auth.signInLater.localized, for: .normal)
        button.setTitleColor(.briefingGray, for: .normal)
        button.titleLabel?.font = .productSans(size: 16, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraint()
    }
    
    private func configure() {
        self.view.setGradient(color1: .briefingBlue, color2: .briefingDarkBlue)
        appleSignInButton.addTarget(self, action: #selector(appleSignIn), for: .touchUpInside)
        googleSignInButon.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        signInLaterButton.addTarget(self, action: #selector(signInLaterButtonAction), for: .touchUpInside)
    }
    
    private func addSubviews() {
        [briefingTitleLabel, briefingDescriptionLabel, briefingChatGPTImageView].forEach { view in
            briefingMainContainer.addSubview(view)
        }
        
        [appleSignInButton, googleSignInButon].forEach { view in
            signInButtonStackView.addArrangedSubview(view)
        }
        
        [briefingMainContainer,
         signInButtonStackView,
         signInButtonDivider,
         signInLaterButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func makeConstraint() {
        briefingMainContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }
        
        briefingTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        briefingDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(briefingTitleLabel.snp.bottom).offset(4)
        }
        
        briefingChatGPTImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(briefingDescriptionLabel.snp.bottom).offset(12)
            make.bottom.equalTo(briefingMainContainer.snp.bottom)
        }
        
        signInButtonStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(36)
            make.trailing.equalToSuperview().inset(36)
            make.top.greaterThanOrEqualTo(briefingMainContainer.snp.bottom)
        }
        
        appleSignInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalToSuperview()
        }
        
        googleSignInButon.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(appleSignInButton.snp.height)
            make.bottom.equalToSuperview()
        }
        
        signInButtonDivider.snp.makeConstraints { make in
            make.top.equalTo(signInButtonStackView.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(36)
            make.trailing.equalToSuperview().inset(36)
            make.height.equalTo(2)
            
        }
        
        signInLaterButton.snp.makeConstraints { make in
            make.top.equalTo(signInButtonDivider.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
        }
    }
}

extension SignInViewController {
    func handleSignInResult(_ result: Bool?,_ error: Error?) {
        if let result = result {
            print("signIn Success \(result)")
        }
        if let error = error {
            print("signIn Fail \(error.localizedDescription)")
        }
        self.navigationController?.popViewController(animated: true)
    }
    @objc func signInLaterButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Google SignIn
extension SignInViewController {
    @objc
    func googleSignIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            do {
                if let error = error { throw error }
                guard let googleUser = signInResult?.user else { throw BriefingAuthError.noDataError }
                self.googleRefreshTokensIfNeeded(user: googleUser)
            } catch {
                self.handleSignInResult(nil, error)
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
                self.authUseCase.signIn(idToken: idToken, socialType: .google)
                    .subscribe(with: self) { owner, result in
                        owner.handleSignInResult(result, nil)
                    } onFailure: { owner, error in
                        owner.handleSignInResult(nil, error)
                    }
                    .disposed(by: self.disposeBag)
            }
            catch {
                self.handleSignInResult(nil, error)
            }
        }
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate,
                                ASAuthorizationControllerPresentationContextProviding {
    
    @objc
    func appleSignIn() {
        appleSignInController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? UIWindow()
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
           let idTokenData = appleIDCredential.identityToken,
           let idToken = String(data: idTokenData, encoding: .utf8) {
            self.authUseCase.signIn(idToken: idToken, socialType: .google)
                .subscribe(with: self) { owner, result in
                    owner.handleSignInResult(result, nil)
                } onFailure: { owner, error in
                    owner.handleSignInResult(nil, error)
                }
                .disposed(by: disposeBag)
        } else {
            authorizationController(controller: controller,
                                    didCompleteWithError: BriefingAuthError.wrongAccessError)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        handleSignInResult(nil, error)
    }
}
