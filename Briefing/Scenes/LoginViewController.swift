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
    
    private var chatGPTImageView : UIImageView = {
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
    }
    
    private func addSubviews() {
        self.view.addSubviews(briefingLabel, descriptionLabel, chatGPTImageView)
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
    }
}
