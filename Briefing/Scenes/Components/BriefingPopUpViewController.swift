//
//  BriefingPopUpViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/16.
//

import UIKit
import SnapKit

class BriefingPopUpViewController: UIViewController {
    var index: Int
    var popUpTitle: String
    var popUpDescription: String
    var cancelButtonText: String
    var confirmButtonText: String
    var style: Style
    
    weak var delegate: BriefingPopUpDelegate?
    
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
    
    
    init(index: Int = 0,
         title: String,
         description: String,
         buttonTitles: [String],
         style: Style) {
        self.index = index
        self.popUpTitle = title
        self.popUpDescription = description
        
        if style == .normal {
            self.cancelButtonText = buttonTitles[0]
            self.confirmButtonText = buttonTitles[0]
        }
        
        else {
            self.cancelButtonText = buttonTitles[0]
            self.confirmButtonText = buttonTitles[1]
        }
        
        self.style = style
        
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
        
        // style에 따라 분리
        if (self.style == .normal) {
            self.mainContainerView.addSubviews(cancelButton)
            cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        }
        
        else {
            self.mainContainerView.addSubviews(buttonStackView)
            [self.cancelButton, self.confirmButton].forEach { buttonStackView.addArrangedSubview($0) }
            cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
            confirmButton.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        }
        
        if (self.style == .twoButtonsDestructive) {
            self.confirmButton.backgroundColor = .briefingRed
        }
        
    }
    
    private func addSubviews() {
        self.view.addSubviews(mainContainerView)
        self.mainContainerView.addSubviews(labelStackView)
        self.mainContainerView.addSubviews(buttonStackView)
        
        [self.titleLabel, self.descriptionLabel].forEach { labelStackView.addArrangedSubview($0) }
        
        // style에 따라 분리
        if (self.style == .normal) {
            [self.cancelButton].forEach { buttonStackView.addArrangedSubview($0) }
        }
        
        else if (self.style == .twoButtonsDefault) {
            [self.cancelButton, self.confirmButton].forEach { buttonStackView.addArrangedSubview($0) }
        }
        
        else if (self.style == .twoButtonsDestructive) {
            [self.cancelButton, self.confirmButton].forEach { buttonStackView.addArrangedSubview($0) }
        }
        
    }
    
    private func makeConstraint() {
        mainContainerView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(307)
        }
        
        labelStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }

        titleLabel.snp.makeConstraints{ make in
        }
        
        descriptionLabel.snp.makeConstraints{ make in
        }
        
        
        buttonStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(22)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }
        
        // style에 따라 분리
        if self.style == .normal {
            cancelButton.snp.makeConstraints{ make in
                make.width.equalTo(265)
                make.height.equalTo(45)
            }
        }
        
        else {
            cancelButton.snp.makeConstraints{ make in
                make.width.equalTo(125)
                make.height.equalTo(45)
            }
        }
        
        confirmButton.snp.makeConstraints{ make in
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
    
    @objc func confirmButtonAction() {
        self.delegate?.confirmButtonTapped(self)
        self.dismiss(animated: false)
    }
    
    @objc func cancelButtonAction() {
        self.delegate?.cancelButtonTapped(self)
        self.dismiss(animated: false)
    }
}

extension BriefingPopUpViewController {
    enum Style: String {
        // button 1개인 경우
        case normal
        // button 2개인 경우
        case twoButtonsDefault
        case twoButtonsDestructive
    }
}

protocol BriefingPopUpDelegate: AnyObject {
    func cancelButtonTapped(_ popupViewController: BriefingPopUpViewController)
    func confirmButtonTapped(_ popupViewController: BriefingPopUpViewController)
}
