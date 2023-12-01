//
//  PurchaseViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 11/30/23.
//

import UIKit

class PurchaseViewController: UIViewController {
    
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
        label.text = "더 강력하고, 더 폭넓은 기능을\nBriefing Premium으로 누려보세요."
        label.asFont(targetString: "Briefing Premium", font: .productSans(size: 20, weight: .bold))
        label.asColor(targetString: "Briefing", color: .bfPrimaryBlue)
        
        return label
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
        
        self.navigationView.addSubviews(backButton, titleLabel)
        
        self.view.addSubviews(navigationView, logoImageView, briefingPremiumLabel, introduceLabel)
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
        }
    }
}

