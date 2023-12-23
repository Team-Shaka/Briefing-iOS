//
//  ScrapbookTableViewCell.swift
//  Briefing
//
//  Created by BoMin Lee on 11/2/23.
//

import UIKit

class ScrapbookTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: ScrapbookTableViewCell.self)
    
    private var mainContainerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var informationLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 13)
        label.textColor = .bfTextGray
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 20, weight: .bold)
        label.textColor = .bfTextBlack
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 17)
        label.textColor = .bfTextGray
        return label
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
    
    private func configure() {
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.layoutMargins = UIEdgeInsets.zero
    }
    
    private func addSubviews() {
        self.contentView.addSubviews(mainContainerView)
        mainContainerView.addSubviews(informationLabel, titleLabel, subtitleLabel)
    }
    
    private func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(14)
            make.leading.equalTo(informationLabel)
        }

        subtitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setCellData(title: String,
                     subtitle: String,
                     date: String,
                     time: String,
                     rank: Int,
                     gptInformation: String) {
        informationLabel.text = "\(date) \(time) | 이슈 #\(rank) | \(gptInformation)로 생성됨"
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
//        mainContainerView.setCornerMask(cornerMaskEdge)
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

//class ScrapbookTableViewCell: UITableViewCell {
//    static let identifier: String = String(describing: ScrapbookTableViewCell.self)
//    
//    private var mainContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 6
//        return view
//    }()
//    
//    private var titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .productSans(size: 17, weight: .bold)
//        label.textColor = .briefingNavy
//        return label
//    }()
//    
//    private var subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .productSans(size: 10)
//        label.textColor = .briefingLightBlue
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    private var dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = .productSans(size: 13)
//        label.textColor = .briefingGray
//        return label
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configure()
//        addSubviews()
//        makeConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure() {
//        self.preservesSuperviewLayoutMargins = false
//        self.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
//        self.layoutMargins = UIEdgeInsets.zero
//    }
//    
//    func addSubviews() {
//        self.contentView.addSubviews(mainContainerView)
//        
//        mainContainerView.addSubviews(titleLabel, subtitleLabel, dateLabel)
//    }
//    
//    func makeConstraints() {
//        mainContainerView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.leading.trailing.equalToSuperview().inset(24)
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(11)
//            make.leading.equalToSuperview().inset(20)
//        }
//        
//        subtitleLabel.snp.makeConstraints{ make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//            make.leading.equalTo(titleLabel)
//            make.trailing.equalToSuperview().inset(20)
//        }
//        
//        dateLabel.snp.makeConstraints{ make in
//            make.top.equalTo(titleLabel)
//            make.trailing.equalToSuperview().inset(16)
//        }
//        
//        
//    }
//    
//    func setCellData(title: String,
//                     subtitle: String,
//                     date: String,
//                     cornerMaskEdge: UIRectEdge?) {
//        titleLabel.text = title
//        subtitleLabel.text = subtitle
//        dateLabel.text = date
//        
//        mainContainerView.setCornerMask(cornerMaskEdge)
//    }
//    
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        self.backgroundColor = .clear
//        if highlighted {
//            mainContainerView.backgroundColor = .briefingLightBlue.withAlphaComponent(0.3)
//        } else {
//            mainContainerView.backgroundColor = .white
//        }
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        self.backgroundColor = .clear
//    }
//
//}
