//
//  PurchaseViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 11/30/23.
//

import UIKit

class PurchaseViewController: UIViewController {
    
    let contentParagraphStyle = NSMutableParagraphStyle()
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.backIconBlackImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
//        button.addTarget(self, action: #selector(goBackToHomeViewController), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .productSans(size: 20)
        label.numberOfLines = 1
        label.text = BriefingStringCollection.Purchase.briefingPremium.localized
        
        return label
    }()
    
    private var purchaseScrollView: UIView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var purchaseView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BriefingImageCollection.briefingLogoImage
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var briefingPremiumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .productSans(size: 20, weight: .bold)
        label.numberOfLines = 1
        label.text = BriefingStringCollection.Purchase.briefingPremium.localized
        label.asColor(targetString: "Briefing", color: .bfPrimaryBlue)
        
        return label
    }()
    
    private var introduceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .productSans(size: 20)
        label.numberOfLines = 2
        label.text = BriefingStringCollection.Purchase.briefingPremiumIntroduction.localized
        label.applyStyles(to: [("Briefing", .productSans(size: 20, weight: .bold), .bfPrimaryBlue),
                               ("Premium", .productSans(size: 20, weight: .bold), nil)])
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .productSans(size: 17)
        label.numberOfLines = 2
        
        self.contentParagraphStyle.lineHeightMultiple = 1.21
        let contextLabelAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.paragraphStyle: self.contentParagraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: BriefingStringCollection.Purchase.briefingPremiumDescription.localized,
                                                  attributes: contextLabelAttributes)
        
        return label
    }()
    
    var purchaseDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var purchaseDescriptionFirstView: PurchaseDescriptionView = {
        let view = PurchaseDescriptionView(descriptionImage: BriefingImageCollection.briefingPurchaseCheckImage,
                                           descriptionText: BriefingStringCollection.Purchase.breifingPremiumFirstDescription.localized)
        
        return view
    }()
    
    private var purchaseDescriptionSecondView: PurchaseDescriptionView = {
        let view = PurchaseDescriptionView(descriptionImage: BriefingImageCollection.briefingPurchaseCheckImage,
                                           descriptionText: BriefingStringCollection.Purchase.breifingPremiumSecondDescription.localized)
        
        return view
    }()
    
    private var purchaseDescriptionThirdView: PurchaseDescriptionView = {
        let view = PurchaseDescriptionView(descriptionImage: BriefingImageCollection.briefingPurchaseCheckImage,
                                           descriptionText: BriefingStringCollection.Purchase.breifingPremiumThirdDescription.localized)
        
        return view
    }()
    
    private var purchaseDescriptionFourthView: PurchaseDescriptionView = {
        let view = PurchaseDescriptionView(descriptionImage: BriefingImageCollection.briefingPurchaseCheckImage,
                                           descriptionText: BriefingStringCollection.Purchase.breifingPremiumFourthDescription.localized)
        
        return view
    }()
    
    private var purchaseDescriptionFifthView: PurchaseDescriptionView = {
        let view = PurchaseDescriptionView(descriptionImage: BriefingImageCollection.briefingPurchaseCheckImage,
                                           descriptionText: BriefingStringCollection.Purchase.breifingPremiumFifthDescription.localized)
        
        return view
    }()
    
    override func viewDidLoad() {
        configure()
        addSubviews()
        makeConstraints()
    }
    
    private func configure() {
        self.view.backgroundColor = .bfWhite
    }
    
    private func addSubviews() {
        [self.purchaseDescriptionFirstView,
         self.purchaseDescriptionSecondView,
         self.purchaseDescriptionThirdView,
         self.purchaseDescriptionFourthView,
         self.purchaseDescriptionFifthView].forEach { purchaseDescriptionStackView.addArrangedSubview($0) }
        
        self.view.addSubviews(navigationView, purchaseScrollView)
        
        self.navigationView.addSubviews(backButton, titleLabel)
        self.purchaseScrollView.addSubview(purchaseView)
        
        self.purchaseView.addSubviews(logoImageView, briefingPremiumLabel, introduceLabel, descriptionLabel, purchaseDescriptionStackView)
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints{ make in
            make.top.equalTo(view)
            make.height.equalTo(90)
            make.leading.trailing.equalTo(view)
        }
        
        backButton.snp.makeConstraints{ make in
            make.bottom.equalTo(navigationView).inset(4)
            make.height.equalTo(33)
            make.width.equalTo(backButton.snp.height)
            make.leading.equalTo(navigationView).inset(19)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
        }
        
        purchaseScrollView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        purchaseView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.width.equalTo(73)
            make.height.equalTo(logoImageView.snp.width)
        }
        
        briefingPremiumLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
        }
        
        introduceLabel.snp.makeConstraints{ make in
            make.top.equalTo(briefingPremiumLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().inset(31)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(29)
            make.leading.trailing.equalTo(introduceLabel)
        }
        
        purchaseDescriptionStackView.snp.makeConstraints{ make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(33)
            make.height.equalTo(150)
        }
        
        
    }
}

