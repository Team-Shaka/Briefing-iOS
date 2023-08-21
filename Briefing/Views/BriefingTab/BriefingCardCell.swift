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
    let button_details1 = UIButton()
    
    let layout_news2 = UIView()
    let label_press2 = UILabel()
    let label_news_title2 = UILabel()
    let button_details2 = UIButton()
    
    let layout_news3 = UIView()
    let label_press3 = UILabel()
    let label_news_title3 = UILabel()
    let button_details3 = UIButton()
    
    
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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(self.frame.width * 0.043)
            make.trailing.equalToSuperview().inset(self.frame.width * 0.043)
        }
        
        layout_main.backgroundColor = .white
        layout_main.layer.cornerRadius = 20
        layout_main.addShadow(offset: CGSize(width: 0, height: 5),
                              color: .black,
                              radius: 5,
                              opacity: 0.1)
        
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
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        label_context.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    
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
            make.bottom.equalTo(layout_main.snp.bottom).inset(25)
        }
        
        layout_news3.layer.masksToBounds = true
        layout_news3.layer.cornerRadius = 10
        layout_news3.layer.borderWidth = 1
        layout_news3.layer.borderColor = UIColor.mainBlue.cgColor
        
        layout_news1.addSubviews(label_press1, label_news_title1, button_details1)
        
        label_press1.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().inset(100)
        }
        
        label_press1.textAlignment = .left
        label_press1.font = UIFont(name: "ProductSans-Bold", size: 13)
        label_press1.textColor = .mainBlue
        label_press1.numberOfLines = 1
        label_press1.lineBreakMode = .byTruncatingTail
        
        label_news_title1.snp.makeConstraints{ make in
            make.top.equalTo(label_press1.snp.bottom).offset(6)
            make.leading.equalTo(label_press1)
            make.trailing.equalToSuperview().inset(100)
        }
        
        label_news_title1.textAlignment = .left
        label_news_title1.font = UIFont(name: "ProductSans-Regular", size: 15)
        label_news_title1.textColor = .mainBlue
        label_news_title1.numberOfLines = 1
        label_news_title1.lineBreakMode = .byTruncatingTail
        
        button_details1.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(7)
            make.width.height.equalTo(27)
        }
        
        button_details1.setImage(UIImage(named: "details"), for: .normal)
        
        layout_news2.addSubviews(label_press2, label_news_title2, button_details2)
        
        label_press2.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().inset(100)
        }
        
        label_press2.textAlignment = .left
        label_press2.font = UIFont(name: "ProductSans-Bold", size: 13)
        label_press2.textColor = .mainBlue
        label_press2.numberOfLines = 1
        label_press2.lineBreakMode = .byTruncatingTail
        
        label_news_title2.snp.makeConstraints{ make in
            make.top.equalTo(label_press2.snp.bottom).offset(6)
            make.leading.equalTo(label_press2)
            make.trailing.equalToSuperview().inset(100)
        }
        
        label_news_title2.textAlignment = .left
        label_news_title2.font = UIFont(name: "ProductSans-Regular", size: 15)
        label_news_title2.textColor = .mainBlue
        label_news_title2.numberOfLines = 1
        label_news_title2.lineBreakMode = .byTruncatingTail
        
        button_details2.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(7)
            make.width.height.equalTo(27)
        }
        
        button_details2.setImage(UIImage(named: "details"), for: .normal)
        
        layout_news3.addSubviews(label_press3, label_news_title3, button_details3)
        
        label_press3.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().inset(100)
        }
        
        label_press3.textAlignment = .left
        label_press3.font = UIFont(name: "ProductSans-Bold", size: 13)
        label_press3.textColor = .mainBlue
        label_press3.numberOfLines = 1
        label_press3.lineBreakMode = .byTruncatingTail
        
        label_news_title3.snp.makeConstraints{ make in
            make.top.equalTo(label_press3.snp.bottom).offset(6)
            make.leading.equalTo(label_press3)
            make.trailing.equalToSuperview().inset(100)
        }
        
        label_news_title3.textAlignment = .left
        label_news_title3.font = UIFont(name: "ProductSans-Regular", size: 15)
        label_news_title3.textColor = .mainBlue
        label_news_title3.numberOfLines = 1
        label_news_title3.lineBreakMode = .byTruncatingTail
        
        button_details3.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(7)
            make.width.height.equalTo(27)
        }
        
        button_details3.setImage(UIImage(named: "details"), for: .normal)
    }
}
