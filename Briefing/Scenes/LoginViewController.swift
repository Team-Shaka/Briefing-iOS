//
//  LoginViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/17.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var briefingText: String = "Briefing"
    var descriptionText: String = "Your Keyword Newskeeper."
    var appleText: String = "Log in with Apple"
    var googleText: String = "Log in with Google"
    var chatGPTBIImage: UIImage = #imageLiteral(resourceName: "login_chatGPTBI")
    
    private var briefingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.font = .productSans(size: 70, weight: .bold)
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.font = .productSans(size: 25)
        
        return label
    }()
    
    private var chatGPTImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
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
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .productSans(size: 15, weight: .bold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private var appleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var googleLoginButon: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        //MARK: ToDo : Add Color to UIColor+
        button.setTitleColor(UIColor(red: 124 / 255, green: 124 / 255, blue: 124 / 255, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .productSans(size: 15, weight: .bold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private var googleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    
    override func viewDidLoad() {
        configure()
        addSubviews()
        makeConstraint()
    }
    
    private func configure() {
        //MARK: ToDo : Add Color to UIColor+
        self.view.setGradient(color1: .briefingBlue, color2: UIColor(red: 48/255, green: 109/255, blue: 171/255, alpha: 1))
        
        
        self.briefingLabel.text = self.briefingText
        self.descriptionLabel.text = self.descriptionText
        self.chatGPTImageView.image = self.chatGPTBIImage
        
        self.appleLoginButton.setTitle(self.appleText, for: .normal)
        self.googleLoginButon.setTitle(self.googleText, for: .normal)
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
        
        googleLoginButon.snp.makeConstraints{ make in
            make.width.equalTo(322)
            make.height.equalTo(50)
        }
    }
}
