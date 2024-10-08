//
//  SettingTableViewButtonCell.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import UIKit

class SettingTableViewAuthCell: UITableViewCell {
    static let identifier: String = String(describing: SettingTableViewAuthCell.self)

    private var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18)
        label.textColor = .bfPrimaryBlue
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
    
    func configure() { }
    
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
            make.leading.equalTo(mainContainerView.snp.leading).inset(30)
            make.trailing.equalTo(mainContainerView.snp.trailing).inset(18)
        }
    }
    
    func setCellData(title: String,
                     color: UIColor) {
        titleLabel.text = title
        titleLabel.textColor = color
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
