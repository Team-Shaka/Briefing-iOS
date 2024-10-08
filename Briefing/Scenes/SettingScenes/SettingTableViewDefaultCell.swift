//
//  SettingTableViewDefaultCell.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import UIKit

class SettingTableViewDefaultCell: UITableViewCell {
    static let identifier: String = String(describing: SettingTableViewDefaultCell.self)
    var isUrlType: Bool = false
    
    private var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18)
        label.textColor = .black
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18)
        label.textColor = .bfPrimaryBlue
        return label
    }()
    
    private var nextIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BriefingImageCollection.nextIconImage
        imageView.tintColor = .black
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
        // self.preservesSuperviewLayoutMargins = false
        // self.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        // self.layoutMargins = UIEdgeInsets.zero
    }
    
    func addSubviews() {
        self.contentView.addSubview(mainContainerView)
        
        let subViews: [UIView] = [titleLabel]
        subViews.forEach { subView in
            mainContainerView.addSubview(subView)
        }
    }
    
    func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(mainContainerView.snp.leading).offset(30)
        }
    }
    
    func setCellData(title: String,
                     type: SettingTableViewDefaultCellType) {
        titleLabel.text = title
        switch type {
        case let .text(text):
            valueLabel.text = text
        default: break
        }
        cellLayoutSetting(type: type)
    }
    
    func cellLayoutSetting(type: SettingTableViewDefaultCellType){
        switch type {
        case .text:
            mainContainerView.addSubview(valueLabel)
            titleLabel.snp.makeConstraints { make in
                make.trailing.lessThanOrEqualTo(valueLabel.snp.leading)
            }
            
            valueLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(18)
            }
        case .url, .pushViewController:
            mainContainerView.addSubview(nextIconImageView)
            titleLabel.snp.makeConstraints { make in
                make.trailing.lessThanOrEqualTo(nextIconImageView.snp.leading)
            }
            
            nextIconImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(18)
                make.width.height.equalTo(20)
            }
        case let .customView(customView):
            mainContainerView.addSubviews(customView)
            
            titleLabel.snp.makeConstraints { make in
                make.trailing.lessThanOrEqualTo(customView.snp.leading)
            }
            
            customView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(18)
            }
        }
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
