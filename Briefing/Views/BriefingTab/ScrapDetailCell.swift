//
//  ScrapDetailCell.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class ScrapDetailCell: UITableViewCell {
    static let cellID = "ScrapDetailCell"
    
    weak var delegate: ScrapDetailCellDelegate?
    
    static let cellHeight: CGFloat = 55.0
    
    let layout_main = UIView()
    
    let label_topic = UILabel()
    let label_sub = UILabel()
    let label_date_info = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .white
        self.contentView.addSubview(layout_main)
        
        layout_main.snp.makeConstraints{ make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        layout_main.backgroundColor = .white
        
        layout_main.addSubviews(label_topic, label_sub, label_date_info)
        
        label_topic.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(11)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(150)
        }
        
        label_topic.font = UIFont(name: "ProductSans-Bold", size: 17)
        label_topic.textAlignment = .left
        label_topic.textColor = .mainBlue
        
        label_sub.snp.makeConstraints{ make in
            make.top.equalTo(label_topic.snp.bottom).offset(5)
            make.leading.trailing.equalTo(label_topic)
        }
        
        label_sub.font = UIFont(name: "ProductSans-Regular", size: 10)
        label_sub.textAlignment = .left
        label_sub.textColor = .thirdBlue
        
        label_date_info.snp.makeConstraints{ make in
            make.top.equalTo(label_topic)
            make.trailing.equalToSuperview().inset(16)
        }
        
        label_date_info.font = UIFont(name: "ProductSans-Regular", size: 13)
        label_date_info.textAlignment = .right
        label_date_info.textColor = .textGray
        
    }
    
    @objc private func scrapDetailTapped() {
        delegate?.didTapScrapDetail(in: self)
    }
}

protocol ScrapDetailCellDelegate: AnyObject {
    func didTapScrapDetail(in cell: ScrapDetailCell)
}
