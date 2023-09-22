//
//  LoginViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/17.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private var briefingLabel: UILabel = {
        let label = UILabel()
        label.text = "Briefing"
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.font = .productSans(size: 70, weight: .bold)
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Keyword Newskeeper."
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
    
    private var loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 23
        
        return stackView
    }()
    
    private var appleLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Log in with Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .productSans(size: 15, weight: .bold)
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
    
    private var googleLoginButon: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Log in with Google", for: .normal)
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
    }
    
    private func addSubviews() {
        self.view.addSubviews(briefingLabel, descriptionLabel, chatGPTImageView, loginButtonStackView)
        
        [self.appleLoginButton, self.googleLoginButon].forEach { loginButtonStackView.addArrangedSubview($0) }
        
        self.appleLoginButton.addSubviews(appleImageView)
        self.googleLoginButon.addSubviews(googleImageView)
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
        
        loginButtonStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.chatGPTImageView.snp.bottom).offset(self.view.bounds.height * 0.271)
            
        }
        
        appleLoginButton.snp.makeConstraints{ make in
            make.width.equalTo(322)
            make.height.equalTo(50)
        }
        
        appleImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.appleLoginButton.snp.leading).offset(72)
        }
        
        googleLoginButon.snp.makeConstraints{ make in
            make.width.equalTo(322)
            make.height.equalTo(50)
        }
        
        googleImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.googleLoginButon.snp.leading).offset(68)
        }
    }
}
