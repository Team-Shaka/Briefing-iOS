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
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 17, weight: .bold)
        label.textColor = .briefingNavy
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 10)
        label.textColor = .briefingLightBlue
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 13)
        label.textColor = .briefingGray
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
    
    func configure() {
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        self.layoutMargins = UIEdgeInsets.zero
    }
    
    func addSubviews() {
        self.contentView.addSubviews(mainContainerView)
        
        mainContainerView.addSubviews(titleLabel, subtitleLabel, dateLabel)
    }
    
    func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        
    }
    
    func setCellData(title: String,
                     subtitle: String,
                     date: String,
                     cornerMaskEdge: UIRectEdge?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        dateLabel.text = date
        
        mainContainerView.setCornerMask(cornerMaskEdge)
    }

}
