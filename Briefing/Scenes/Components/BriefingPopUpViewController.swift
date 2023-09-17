//
//  BriefingPopUpViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/16.
//

import UIKit
import SnapKit

class BriefingPopUpViewController: UIViewController {
    
    var popUpTitle: String
    var popUpDescription: String
    var cancelButtonText: String
    var confirmButtonText: String
    
    var style: BriefingPopUpViewController.Style
    
    private var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .productSans(size: 20, weight: .bold)
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .productSans(size: 15)
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    private var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 13
            
        return stackView
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonGray
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .productSans(size: 15, weight: .bold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .productSans(size: 15, weight: .bold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        return stackView
    }()
    
    
    init(title: String,
         description: String,
         buttonTitles: [String],
         style: Style=Style()) {
//        self.url = url
//        self.metadata = metadata
        self.style = style
        self.popUpTitle = title
        self.popUpDescription = description
        self.cancelButtonText = buttonTitles[0]
        self.confirmButtonText = buttonTitles[1]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configure()
        addSubviews()
        makeConstraint()
    }
    
    private func configure() {
        self.view.backgroundColor = .dimGray
        self.titleLabel.text = self.popUpTitle
        self.descriptionLabel.text = self.popUpDescription
        self.cancelButton.setTitle(self.cancelButtonText, for: .normal)
        self.confirmButton.setTitle(self.confirmButtonText, for: .normal)
    }
    
    private func addSubviews() {
        self.view.addSubviews(mainContainerView)
        self.mainContainerView.addSubviews(labelStackView, buttonStackView)
        
        [self.titleLabel, self.descriptionLabel].forEach { labelStackView.addArrangedSubview($0) }
        [self.cancelButton, self.confirmButton].forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    private func makeConstraint() {
        mainContainerView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(307)
//            make.height.equalTo(185)
        }
        
        labelStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }

        titleLabel.snp.makeConstraints{ make in
//            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints{ make in
//            make.leading.equalToSuperview().offset(24)
//            make.trailing.equalToSuperview().inset(24)
        }
        
        buttonStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(22)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }
        
        cancelButton.snp.makeConstraints{ make in
//            make.top.equalTo(self.descriptionLabel).offset(22)
            make.width.equalTo(125)
            make.height.equalTo(45)
        }
        
        confirmButton.snp.makeConstraints{ make in
//            make.top.equalTo(self.cancelButton)
            make.width.equalTo(125)
            make.height.equalTo(45)
        }
        
        mainContainerView.snp.remakeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(307)
            make.top.equalTo(self.labelStackView.snp.top).offset(28)
            make.bottom.equalTo(self.buttonStackView.snp.bottom).offset(16)
        }
    }
    
}

