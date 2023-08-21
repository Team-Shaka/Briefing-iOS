//
//  BriefingCardCell.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class BriefingCardCell: UITableViewCell {
    static let cellID = "BrefingCardCell"
    
    let layout_main = UIView()
    
    let label_info = UILabel()
    let label_topic = UILabel()
    let label_sub = UILabel()
    let label_context = UILabel()
    
    let label_related = UILabel()
    
    let layout_news1 = UIView()
    let label_press1 = UILabel()
    let label_news_title1 = UILabel()
    
    let layout_news2 = UIView()
    let label_press2 = UILabel()
    let label_news_title2 = UILabel()
    
    let layout_news3 = UIView()
    let label_press3 = UILabel()
    let label_news_title3 = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .secondBlue
        self.addSubview(layout_main)
        
        layout_main.snp.makeConstraints{ make in
            make.top.height.equalToSuperview()
            make.leading.equalToSuperview().offset(self.frame.width * 0.043)
            make.trailing.equalToSuperview().inset(self.frame.width * 0.043)
        }
        
        layout_main.backgroundColor = .white
        layout_main.addShadow(offset: CGSize(width: 0, height: 4),
                              color: .black,
                              radius: 5,
                              opacity: 0.1)
        layout_main.layer.masksToBounds = true
        layout_main.layer.cornerRadius = 20
        
        layout_main.addSubviews(label_info, label_topic, label_sub, label_context, label_related)
        
        label_info.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().inset(12)
        }
        
//        label_info.text = "00.00.00 Briefing #1"
        label_info.font = UIFont(name: "ProductSans-Regular", size: 14)
        label_info.textColor = .thirdBlue
        label_info.textAlignment = .right
        
        label_topic.snp.makeConstraints{ make in
            make.top.equalTo(label_info.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(self.frame.width * 0.064)
            make.trailing.equalToSuperview().inset(self.frame.width * 0.064)
        }
        
        label_topic.textColor = .mainBlue
        label_topic.textAlignment = .left
        label_topic.font = UIFont(name: "ProductSans-Bold", size: 30)
        label_topic.numberOfLines = 1
        
        label_sub.snp.makeConstraints{ make in
            make.top.equalTo(label_topic.snp.bottom).offset(12)
            make.leading.trailing.equalTo(label_topic)
        }
        
        label_sub.textColor = .mainBlue
        label_sub.textAlignment = .left
        label_sub.font = UIFont(name: "ProductSans-Bold", size: 15)
        label_sub.numberOfLines = 1
        
        label_context.snp.makeConstraints{ make in
            make.top.equalTo(label_sub.snp.bottom).offset(12)
            make.leading.trailing.equalTo(label_topic)
        }
        
        label_context.textColor = .mainBlue
        label_context.textAlignment = .left
        label_context.font = UIFont(name: "ProductSans-Regular", size: 13)
        label_context.numberOfLines = 0
        label_context.lineBreakMode = .byCharWrapping
    
        label_related.snp.makeConstraints{ make in
            make.top.equalTo(label_context.snp.bottom).offset(30)
            make.leading.trailing.equalTo(label_topic)
        }
        
        label_related.text = "관련 기사"
        label_related.textColor = .mainBlue
        label_related.textAlignment = .left
        label_related.font = UIFont(name: "ProductSans-Bold", size: 15)
        label_related.numberOfLines = 1

        layout_main.addSubviews(layout_news1, layout_news2, layout_news3)
        
        layout_news1.snp.makeConstraints{ make in
            make.top.equalTo(label_related.snp.bottom).offset(11)
            make.leading.trailing.equalTo(label_topic)
            make.height.equalTo(60)
        }
        
        layout_news1.layer.masksToBounds = true
        layout_news1.layer.cornerRadius = 10
        layout_news1.layer.borderWidth = 1
        layout_news1.layer.borderColor = UIColor.mainBlue.cgColor
        
        layout_news2.snp.makeConstraints{ make in
            make.top.equalTo(layout_news1.snp.bottom).offset(8)
            make.leading.trailing.equalTo(label_topic)
            make.height.equalTo(60)
        }
        
        layout_news2.layer.masksToBounds = true
        layout_news2.layer.cornerRadius = 10
        layout_news2.layer.borderWidth = 1
        layout_news2.layer.borderColor = UIColor.mainBlue.cgColor
        
        layout_news3.snp.makeConstraints{ make in
            make.top.equalTo(layout_news2.snp.bottom).offset(8)
            make.leading.trailing.equalTo(label_topic)
            make.height.equalTo(60)
        }
        
        layout_news3.layer.masksToBounds = true
        layout_news3.layer.cornerRadius = 10
        layout_news3.layer.borderWidth = 1
        layout_news3.layer.borderColor = UIColor.mainBlue.cgColor
    }
}
