//
//  PurchaseDescriptionView.swift
//  Briefing
//
//  Created by BoMin Lee on 12/2/23.
//

import UIKit
import SnapKit

class PurchaseDescriptionView: UIView {
    let descriptionImage: UIImage
    let descriptionText: String
    let contentParagraphStyle = NSMutableParagraphStyle()
    
    private lazy var descriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.descriptionImage
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .productSans(size: 17)
        label.numberOfLines = 1
        
        self.contentParagraphStyle.lineHeightMultiple = 1.21
        let contextLabelAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.paragraphStyle: self.contentParagraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: self.descriptionText,
                                                  attributes: contextLabelAttributes)
        
        return label
    }()
    
    init(descriptionImage: UIImage,
         descriptionText: String) {
        self.descriptionImage = descriptionImage
        self.descriptionText = descriptionText
        super.init(frame: .zero)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .clear
    }
    
    private func addSubviews() {
        self.addSubviews(descriptionImageView, descriptionLabel)
    }
    
    private func makeConstraints() {
        descriptionImageView.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(21)
            make.height.equalTo(descriptionImageView.snp.width)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.leading.equalTo(descriptionImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
    }
}
