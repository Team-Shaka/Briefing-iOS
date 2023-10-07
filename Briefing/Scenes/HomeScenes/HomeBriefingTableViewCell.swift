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
        view.backgroundColor = .white
        view.layer.cornerRadius = 26
        view.addShadow(offset: CGSize(width: 0, height: 4),
                       color: .black,
                       radius: 5,
                       opacity: 0.1)
        return view
    }()
    
    private var rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingNavy
        label.font = .productSans(size: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 46/2
        return label
    }()
    
    private var textContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingNavy
        label.font = .productSans(size: 20, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingLightBlue
        label.font = .productSans(size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private var nextIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BriefingImageCollection.nextIconImage
        imageView.tintColor = .briefingNavy
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        
        let subViews: [UIView] = [rankLabel, textContainer, nextIconImageView]
        subViews.forEach { subView in
            mainContainerView.addSubview(subView)
        }
    }
    
    func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(72)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.width.height.equalTo(46)
        }
        
        nextIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
            make.width.height.equalTo(28)
        }
        
        textContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankLabel.snp.trailing).offset(12)
            make.top.equalTo(titleLabel.snp.top)
            make.bottom.equalTo(descriptionLabel.snp.bottom)
            make.trailing.equalTo(nextIconImageView.snp.leading).offset(12)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(textContainer)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(textContainer)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    func updateKeywordBriefing(_ keywordBriefing: KeywordBriefing) {
        self.keywordBriefing = keywordBriefing
        switch keywordBriefing.ranks {
        case 1:
            rankLabel.textColor = .white
            rankLabel.backgroundColor = .briefingNavy
        case 2:
            rankLabel.textColor = .white
            rankLabel.backgroundColor = .briefingBlue
        case 3:
            rankLabel.textColor = .white
            rankLabel.backgroundColor = .briefingLightBlue
        default:
            rankLabel.textColor = .briefingNavy
            rankLabel.backgroundColor = .clear
        }
        rankLabel.text = "\(keywordBriefing.ranks)"
        titleLabel.text = keywordBriefing.title
        descriptionLabel.text = keywordBriefing.subTitle
        layoutIfNeeded()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.backgroundColor = .clear
        if highlighted {
            mainContainerView.backgroundColor = .briefingLightBlue.withAlphaComponent(0.3)
        } else {
            mainContainerView.backgroundColor = .white
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.backgroundColor = .clear
    }
}
