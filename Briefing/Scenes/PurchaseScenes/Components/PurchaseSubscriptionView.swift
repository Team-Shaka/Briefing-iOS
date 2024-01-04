//
//  PurchaseSubscriptionView.swift
//  Briefing
//
//  Created by BoMin Lee on 12/5/23.
//

import UIKit

class PurchaseSubscriptionView: UIView {
    var style: Style
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var discountLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 13)
        label.textColor = .bfPrimaryBlue
        return label
    }()
    
    init(style: Style) {
        self.style = style
        
        super.init(frame: .zero)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        switch style {
        case .yearly:
            titleLabel.text = BriefingStringCollection.Purchase.briefingPremiumPurchaseYearly.localized
            priceLabel.text = BriefingStringCollection.Purchase.briefingPremiumPurchaseYearlyPrice.localized
        case .monthly:
            titleLabel.text = BriefingStringCollection.Purchase.briefingPremiumPurchaseMonthly.localized
            priceLabel.text = BriefingStringCollection.Purchase.briefingPremiumPurchaseMonthlyPrice.localized
        }
        
        titleLabel.asColor(targetString: "Briefing", color: .bfPrimaryBlue)
    }
    
    private func addSubviews() {
        switch style {
        case .yearly:
            self.addSubviews(titleLabel, priceLabel, discountLabel)
        case .monthly:
            self.addSubviews(titleLabel, priceLabel)
        }
    }
    
    private func makeConstraints() {
        switch style {
        case .yearly:
            titleLabel.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(14)
                make.centerX.equalToSuperview()
            }
            
            priceLabel.snp.makeConstraints{ make in
                make.top.equalTo(titleLabel.snp.bottom).offset(26)
                make.centerX.equalToSuperview()
            }
            
            discountLabel.snp.makeConstraints{ make in
                make.top.equalTo(priceLabel.snp.bottom).offset(6)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(18)
            }
            
        case .monthly:
            titleLabel.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(14)
                make.centerX.equalToSuperview()
            }
            
            priceLabel.snp.makeConstraints{ make in
                make.top.equalTo(titleLabel.snp.bottom).offset(26)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(18)
            }
        }
    }
}

extension PurchaseSubscriptionView {
    enum Style {
        case yearly
        case monthly
    }
}
