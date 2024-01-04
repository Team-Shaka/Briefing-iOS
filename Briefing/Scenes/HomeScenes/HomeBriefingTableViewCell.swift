//
//  HomeBriefingTableViewCell.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/03.
//

import UIKit

class HomeBriefingTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: HomeBriefingTableViewCell.self)
    var keywordBriefing: KeywordBriefing? = nil
    
    private var mainContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .bfPrimaryBlue
        label.font = .productSans(size: 35, weight: .bold)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private var textContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .bfTextBlack
        label.font = .productSans(size: 20, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .bfTextGray
        label.font = .productSans(size: 16)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    private var scrapCountContainer: UIView = UIView()
    
    private var scrapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BriefingImageCollection.scrapCountImage
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var scrapCountLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 14)
        label.textColor = .bfTextGray
        return label
    }()
    
    private var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .bfSeperatorGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    func addSubviews() {
        self.contentView.addSubview(mainContainerView)
        
        let textContainerSubViews: [UIView] = [titleLabel, descriptionLabel]
        textContainerSubViews.forEach { view in
            textContainer.addSubview(view)
        }
        
        let scrapCountContainerSubviews: [UIView] = [scrapImageView, scrapCountLabel]
        scrapCountContainerSubviews.forEach { view in
            scrapCountContainer.addSubview(view)
        }
        
        let subViews: [UIView] = [rankLabel, textContainer, scrapCountContainer, divider]
        subViews.forEach { subView in
            mainContainerView.addSubview(subView)
        }
    }
    
    func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(120)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        textContainer.snp.makeConstraints { make in
            make.top.equalTo(rankLabel)
            make.leading.equalTo(rankLabel.snp.trailing).offset(14)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(textContainer)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(textContainer)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        scrapCountContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(16)
            make.bottom.equalTo(divider.snp.top).offset(-6)
            make.leading.greaterThanOrEqualTo(textContainer).priority(.low)
        }
        
        scrapImageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(scrapImageView.snp.height)
            make.centerY.leading.equalToSuperview()
        }
        
        scrapCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrapImageView.snp.trailing)
            make.centerY.height.trailing.equalToSuperview()
        }
        
        divider.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func updateKeywordBriefing(_ keywordBriefing: KeywordBriefing) {
        self.keywordBriefing = keywordBriefing
        rankLabel.text = "\(keywordBriefing.ranks)."
        titleLabel.text = keywordBriefing.title
        descriptionLabel.text = keywordBriefing.subTitle
        scrapCountLabel.text = "\(keywordBriefing.scrapCount >= 1000 ? "+1K" : "+\(keywordBriefing.scrapCount)")"
        layoutIfNeeded()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.backgroundColor = .briefingLightBlue.withAlphaComponent(0.3)
        } else {
            self.backgroundColor = .white
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}
