//
//  SignInViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/17.
//

import UIKit
import SnapKit
import AuthenticationServices

class SignInViewController: UIViewController {
    private let authManager: BriefingAuthManager = BriefingAuthManager.shared
    
    private var briefingLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.appName
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.font = .productSans(size: 70, weight: .bold)
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.appDescription
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.font = .productSans(size: 25)

        return label
    }()
    
    private var chatGPTImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "login_chatGPTBI")
        
        return imageView
    }()
    
    private var signInButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 23
        
        return stackView
    }()
    
    private lazy var appleSignInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle(BriefingStringCollection.Auth.signInWithApple.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .productSans(size: 16, weight: .bold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private var appleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "login_apple")
        
        return imageView
    }()
    
    private var googleSignInButon: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(BriefingStringCollection.Auth.signInWithGoogle.localized, for: .normal)
        button.setTitleColor(.googleGray, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .productSans(size: 15, weight: .bold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    private var googleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "login_google")
        return imageView
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
    }
    
    private func addSubviews() {
        self.view.addSubviews(briefingLabel, descriptionLabel, chatGPTImageView, signInButtonStackView)
        
        [self.appleSignInButton, self.googleSignInButon].forEach { button in
            signInButtonStackView.addArrangedSubview(button)
        }
        
        self.appleSignInButton.addSubviews(appleImageView)
        self.googleSignInButon.addSubviews(googleImageView)
    }
    
    private func makeConstraint() {
        briefingLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(self.view.bounds.height * 0.204)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(self.briefingLabel)
            make.top.equalTo(self.briefingLabel.snp.bottom).offset(10)
        }
        
        chatGPTImageView.snp.makeConstraints{ make in
            make.centerX.equalTo(self.briefingLabel)
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(19)
        }
        
        signInButtonStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.chatGPTImageView.snp.bottom).offset(self.view.bounds.height * 0.271)
            
        }
        
        appleSignInButton.snp.makeConstraints{ make in
            make.width.equalTo(322)
            make.height.equalTo(50)
        }
        
        appleImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.appleSignInButton.snp.leading).offset(72)
        }
        
        googleSignInButon.snp.makeConstraints{ make in
            make.width.equalTo(322)
            make.height.equalTo(50)
        }
        
        googleImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.googleSignInButon.snp.leading).offset(68)
        }
    }
    
    @objc func appleSignIn() {
        authManager.appleSignIn(withPresentation: self) { [weak self] member, error in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func googleSignIn() {
        authManager.googleSignIn(withPresentation: self) { [weak self] member, error in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

