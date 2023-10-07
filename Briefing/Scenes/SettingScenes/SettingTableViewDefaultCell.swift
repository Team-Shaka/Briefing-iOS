//
//  SettingTableViewDefaultCell.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import UIKit

class SettingTableViewDefaultCell: UITableViewCell, SettingTableViewCell {
    static let identifier: String = String(describing: SettingTableViewDefaultCell.self)
    var isUrlType: Bool = false
    
    private var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .briefingNavy
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18)
        label.textColor = .briefingNavy
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18)
        label.textColor = .briefingNavy
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
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        self.layoutMargins = UIEdgeInsets.zero
    }
    
    func addSubviews() {
        self.contentView.addSubview(mainContainerView)
        
        let subViews: [UIView] = [symbolImageView, titleLabel, valueLabel, nextIconImageView]
        subViews.forEach { subView in
            mainContainerView.addSubview(subView)
        }
    }
    
    func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        symbolImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(symbolImageView.snp.trailing).offset(12)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
        }
        
        nextIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
            make.width.height.equalTo(20)
        }
    }
    
    func setCellData(symbol: UIImage,
                     title: String,
                     value: String?,
                     urlString: String?,
                     cornerMaskEdge: UIRectEdge?) {
        symbolImageView.image = symbol
        titleLabel.text = title
        if urlString != nil {
            self.isUrlType = true
            valueLabel.isHidden = true
            titleLabel.snp.makeConstraints { make in
                make.trailing.lessThanOrEqualTo(nextIconImageView.snp.leading)
            }
        } else {
            valueLabel.text = value
            nextIconImageView.isHidden = true
            titleLabel.snp.makeConstraints { make in
                make.trailing.lessThanOrEqualTo(valueLabel.snp.leading)
            }
        }
        mainContainerView.setCornerMask(cornerMaskEdge)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.backgroundColor = .clear
        guard isUrlType else { return }
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
