//
//  BriefingCardCell.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit
import SnapKit

//class BriefingCardCell: UITableViewCell {
//    static let identifier = "BrefingCardCell"
//
//    let layout_main = UIView()
//
//    let label_info = UILabel()
//    let label_topic = UILabel()
//    let label_sub = UILabel()
//    let label_context = UILabel()
//
//    let label_related = UILabel()
//
//    var newsArray = ["", "", ""]
//
//    let layout_news1 = UIView()
//    let label_press1 = UILabel()
//    let label_news_title1 = UILabel()
//    let button_details1 = UIButton()
//
//    let layout_news2 = UIView()
//    let label_press2 = UILabel()
//    let label_news_title2 = UILabel()
//    let button_details2 = UIButton()
//
//    let layout_news3 = UIView()
//    let label_press3 = UILabel()
//    let label_news_title3 = UILabel()
//    let button_details3 = UIButton()
//
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
//        setLayout()
//        print("CARD HEIGHT:", self.contentView.frame.height)
////        controlNewsCount(news: newsArray)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setLayout() {
//        self.backgroundColor = .clear
////        self.contentView.setGradient(color1: .secondBlue, color2: .mainBlue)
//        self.contentView.addSubview(layout_main)
////        self.addSubview(layout_main)
//
//        layout_main.snp.makeConstraints{ make in
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview().offset(self.frame.width * 0.043)
//            make.trailing.equalToSuperview().inset(self.frame.width * 0.043)
//        }
//
//        layout_main.backgroundColor = .white
//        layout_main.layer.cornerRadius = 20
//        layout_main.addShadow(offset: CGSize(width: 0, height: 5),
//                              color: .black,
//                              radius: 5,
//                              opacity: 0.1)
//
//        layout_main.addSubviews(label_info, label_topic, label_sub, label_context, label_related)
//
//        label_info.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(11)
//            make.trailing.equalToSuperview().inset(12)
//        }
//
////        label_info.text = "00.00.00 Briefing #1"
//        label_info.font = .productSans(size: 14)
//        label_info.textColor = .thirdBlue
//        label_info.textAlignment = .right
//
//        label_topic.snp.makeConstraints{ make in
//            make.top.equalTo(label_info.snp.bottom).offset(13)
//            make.leading.equalToSuperview().offset(self.frame.width * 0.064)
//            make.trailing.equalToSuperview().inset(self.frame.width * 0.064)
//        }
//
//        label_topic.textColor = .mainBlue
//        label_topic.textAlignment = .left
//        label_topic.font = .productSans(size: 30, weight: .bold)
//        label_topic.numberOfLines = 1
//
//        label_sub.snp.makeConstraints{ make in
//            make.top.equalTo(label_topic.snp.bottom).offset(12)
//            make.leading.trailing.equalTo(label_topic)
//        }
//
//        label_sub.textColor = .mainBlue
//        label_sub.textAlignment = .left
//        label_sub.font = .productSans(size: 15, weight: .bold)
//        label_sub.numberOfLines = 1
//
//        label_context.snp.makeConstraints{ make in
//            make.top.equalTo(label_sub.snp.bottom).offset(12)
//            make.leading.trailing.equalTo(label_topic)
//        }
//
//        label_context.textColor = .mainBlue
//        label_context.textAlignment = .left
//        label_context.font = .productSans(size: 13)
//        label_context.numberOfLines = 0
//        label_context.lineBreakMode = .byCharWrapping
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.4
//        label_context.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//
//        label_related.snp.makeConstraints{ make in
//            make.top.equalTo(label_context.snp.bottom).offset(30)
//            make.leading.trailing.equalTo(label_topic)
//        }
//
//        label_related.text = "관련 기사"
//        label_related.textColor = .mainBlue
//        label_related.textAlignment = .left
//        label_related.font = .productSans(size: 15, weight: .bold)
//        label_related.numberOfLines = 1
//
//        layout_main.addSubviews(layout_news1, layout_news2, layout_news3)
//
//        layout_news1.snp.makeConstraints{ make in
//            make.top.equalTo(label_related.snp.bottom).offset(11)
//            make.leading.trailing.equalTo(label_topic)
//            make.height.equalTo(60)
//        }
//
//        layout_news1.layer.masksToBounds = true
//        layout_news1.layer.cornerRadius = 10
//        layout_news1.layer.borderWidth = 1
//        layout_news1.layer.borderColor = UIColor.mainBlue.cgColor
//
//        layout_news2.snp.makeConstraints{ make in
//            make.top.equalTo(layout_news1.snp.bottom).offset(8)
//            make.leading.trailing.equalTo(label_topic)
//            make.height.equalTo(60)
//        }
//
//        layout_news2.layer.masksToBounds = true
//        layout_news2.layer.cornerRadius = 10
//        layout_news2.layer.borderWidth = 1
//        layout_news2.layer.borderColor = UIColor.mainBlue.cgColor
//
//        layout_news3.snp.makeConstraints{ make in
//            make.top.equalTo(layout_news2.snp.bottom).offset(8)
//            make.leading.trailing.equalTo(label_topic)
//            make.height.equalTo(60)
//        }
//
//        layout_news3.layer.masksToBounds = true
//        layout_news3.layer.cornerRadius = 10
//        layout_news3.layer.borderWidth = 1
//        layout_news3.layer.borderColor = UIColor.mainBlue.cgColor
//
//        layout_news1.addSubviews(label_press1, label_news_title1, button_details1)
//
//        label_press1.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(9)
//            make.leading.equalToSuperview().offset(13)
//            make.trailing.equalToSuperview().inset(100)
//        }
//
//        label_press1.textAlignment = .left
//        label_press1.font = .productSans(size: 13, weight: .bold)
//        label_press1.textColor = .mainBlue
//        label_press1.numberOfLines = 1
//        label_press1.lineBreakMode = .byTruncatingTail
//
//        label_news_title1.snp.makeConstraints{ make in
//            make.top.equalTo(label_press1.snp.bottom).offset(6)
//            make.leading.equalTo(label_press1)
//            make.trailing.equalToSuperview().inset(100)
//        }
//
//        label_news_title1.textAlignment = .left
//        label_news_title1.font = .productSans(size: 15)
//        label_news_title1.textColor = .mainBlue
//        label_news_title1.numberOfLines = 1
//        label_news_title1.lineBreakMode = .byTruncatingTail
//
//        button_details1.snp.makeConstraints{ make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().inset(7)
//            make.width.height.equalTo(27)
//        }
//
//        button_details1.setImage(UIImage(named: "details"), for: .normal)
//
//        layout_news2.addSubviews(label_press2, label_news_title2, button_details2)
//
//        label_press2.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(9)
//            make.leading.equalToSuperview().offset(13)
//            make.trailing.equalToSuperview().inset(100)
//        }
//
//        label_press2.textAlignment = .left
//        label_press2.font = .productSans(size: 13, weight: .bold)
//        label_press2.textColor = .mainBlue
//        label_press2.numberOfLines = 1
//        label_press2.lineBreakMode = .byTruncatingTail
//
//        label_news_title2.snp.makeConstraints{ make in
//            make.top.equalTo(label_press2.snp.bottom).offset(6)
//            make.leading.equalTo(label_press2)
//            make.trailing.equalToSuperview().inset(100)
//        }
//
//        label_news_title2.textAlignment = .left
//        label_news_title2.font = .productSans(size: 15)
//        label_news_title2.textColor = .mainBlue
//        label_news_title2.numberOfLines = 1
//        label_news_title2.lineBreakMode = .byTruncatingTail
//
//        button_details2.snp.makeConstraints{ make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().inset(7)
//            make.width.height.equalTo(27)
//        }
//
//        button_details2.setImage(UIImage(named: "details"), for: .normal)
//
//        layout_news3.addSubviews(label_press3, label_news_title3, button_details3)
//
//        label_press3.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(9)
//            make.leading.equalToSuperview().offset(13)
//            make.trailing.equalToSuperview().inset(100)
//        }
//
//        label_press3.textAlignment = .left
//        label_press3.font = .productSans(size: 13, weight: .bold)
//        label_press3.textColor = .mainBlue
//        label_press3.numberOfLines = 1
//        label_press3.lineBreakMode = .byTruncatingTail
//
//        label_news_title3.snp.makeConstraints{ make in
//            make.top.equalTo(label_press3.snp.bottom).offset(6)
//            make.leading.equalTo(label_press3)
//            make.trailing.equalToSuperview().inset(100)
//        }
//
//        label_news_title3.textAlignment = .left
//        label_news_title3.font = .productSans(size: 15)
//        label_news_title3.textColor = .mainBlue
//        label_news_title3.numberOfLines = 1
//        label_news_title3.lineBreakMode = .byTruncatingTail
//
//        button_details3.snp.makeConstraints{ make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().inset(7)
//            make.width.height.equalTo(27)
//        }
//
//        button_details3.setImage(UIImage(named: "details"), for: .normal)
//    }
//
//    func controlNewsCount(news: [String]) {
//        if news[1] == "" {
//            print("one")
//            layout_news2.isHidden = true
//            layout_news3.isHidden = true
//
////            layout_news1.snp.remakeConstraints{ make in
////                make.top.equalTo(label_related.snp.bottom).offset(11)
////                make.leading.trailing.equalTo(label_topic)
////                make.height.equalTo(60)
////            }
//
//            layout_main.snp.remakeConstraints { make in
//                make.top.equalToSuperview()
//                make.leading.equalToSuperview().offset(self.frame.width * 0.043)
//                make.trailing.equalToSuperview().inset(self.frame.width * 0.043)
//                make.bottom.equalTo(layout_news1.snp.bottom).offset(25)
//            }
//
//        } else if news[2] == "" {
//            print("two")
//            layout_news2.isHidden = false
//            layout_news3.isHidden = true
//
////            layout_news1.snp.remakeConstraints{ make in
////                make.top.equalTo(label_related.snp.bottom).offset(11)
////                make.leading.trailing.equalTo(label_topic)
////                make.height.equalTo(60)
////            }
////
////            layout_news2.snp.remakeConstraints{ make in
////                make.top.equalTo(layout_news1.snp.bottom).offset(8)
////                make.leading.trailing.equalTo(label_topic)
////                make.height.equalTo(60)
////            }
//
//            layout_main.snp.remakeConstraints { make in
//                make.top.equalToSuperview()
//                make.leading.equalToSuperview().offset(self.frame.width * 0.043)
//                make.trailing.equalToSuperview().inset(self.frame.width * 0.043)
//                make.bottom.equalTo(layout_news2.snp.bottom).offset(25)
//            }
//
//        } else {
//            print("three")
//            layout_news2.isHidden = false
//            layout_news3.isHidden = false
//
////            layout_news1.snp.remakeConstraints{ make in
////                make.top.equalTo(label_related.snp.bottom).offset(11)
////                make.leading.trailing.equalTo(label_topic)
////                make.height.equalTo(60)
////            }
////
////            layout_news2.snp.remakeConstraints{ make in
////                make.top.equalTo(layout_news1.snp.bottom).offset(8)
////                make.leading.trailing.equalTo(label_topic)
////                make.height.equalTo(60)
////            }
////
////            layout_news3.snp.remakeConstraints{ make in
////                make.top.equalTo(layout_news2.snp.bottom).offset(8)
////                make.leading.trailing.equalTo(label_topic)
////                make.height.equalTo(60)
////            }
//
//            layout_main.snp.remakeConstraints { make in
//                make.top.equalToSuperview()
//                make.leading.equalToSuperview().offset(self.frame.width * 0.043)
//                make.trailing.equalToSuperview().inset(self.frame.width * 0.043)
//                make.bottom.equalTo(layout_news3.snp.bottom).offset(25)
//            }
//        }
//
//        self.layoutIfNeeded()
//
//    }
//}

class BriefingCardCell: UITableViewCell {
    static let identifier = "BriefingCardCell"
    
    private var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addShadow(offset: CGSize(width: 0, height: 5),
                       color: .black,
                       radius: 5,
                       opacity: 0.1)
        
        return view
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .thirdBlue
        label.textAlignment = .right
        label.font = .productSans(size: 14)
        
        return label
    }()
    
    private var topicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 35, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var subtopicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 17, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var contextLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    private var chatView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.briefingNavy.cgColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private var chatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "brief_chat_beta")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var chatLabel: UILabel = {
        let label = UILabel()
        label.text = "Brief에게 물어보기"
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 15, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var chatBetaLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var chatDetailsButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private var relatedLabel: UILabel = {
        let label = UILabel()
        label.text = "관련 기사"
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 15, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var news1View: UIView = {
        let view = UIView()
        
        
        return view
    }()
    
    private var press1Label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var newsTitle1Label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var details1Button: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private var news2View: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var press2Label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var newsTitle2Label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var details2Button: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private var news3View: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var press3Label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var newsTitle3Label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var details3Button: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addSubviews()
        setTexts()
        makeConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    private func addSubviews() {
        self.contentView.addSubview(mainView)
        mainView.addSubviews(infoLabel, topicLabel, subtopicLabel, contextLabel, chatView, relatedLabel)
        mainView.addSubviews(news1View, news2View, news3View)
        chatView.addSubviews(chatImageView, chatLabel, chatBetaLabel, chatDetailsButton)
        
        news1View.addSubviews(press1Label, newsTitle1Label, details1Button)
        news2View.addSubviews(press2Label, newsTitle2Label, details2Button)
        news3View.addSubviews(press3Label, newsTitle3Label, details3Button)
    }
    
    //MARK: To be deleted.
    private func setTexts() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.37
        
        infoLabel.text = "00.00.00 Briefing #1"
        topicLabel.text = "배터리 혁명"
        subtopicLabel.text = "2차 전지 혁명으로 인한 놀라운 발전과 진보가 이루어졌다. 2차 전지 혁명으로 인한 놀라운 발전과 진보가 이루어진다. 2차 전지 혁명으로 인한 놀라운 발전과 진보가 이루어질 것이다."
        contextLabel.attributedText = NSMutableAttributedString(string: "배터리 혁명은 현대 산업과 일상 생활에 혁명적인 변화를 가져왔다. 전기 자동차 및 이동식 장치들은 더 큰 용량과 효율성을 가진 배터리로 긴 주행거리와 높은 성능을 실현하였다. 또한 재생 에너지 저장 시스템으로 활용되어 전력 그리드 안정성을 증진시키고 친환경 에너지 전환을 촉진하고 있다. 연구의 진보로 배터리 수명과 충전 시간이 개선되며, 이는 모바일 기기부터 심지어 대규모 에너지 저장까지 다양한 분야에서 혁신을 이뤄내고 있다.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private func makeConstraint() {
        mainView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(17)
        }
        
        infoLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().inset(12)
        }
        
        topicLabel.snp.makeConstraints{ make in
            make.top.equalTo(infoLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(25)
        }
        
        subtopicLabel.snp.makeConstraints{ make in
            make.top.equalTo(topicLabel.snp.bottom).offset(12)
            make.leading.equalTo(topicLabel)
            make.trailing.equalToSuperview().inset(25)
        }
        
        contextLabel.snp.makeConstraints{ make in
            make.top.equalTo(subtopicLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(subtopicLabel)
        }
        
        chatView.snp.makeConstraints{ make in
            make.top.equalTo(contextLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().inset(23)
            make.height.equalTo(60)
        }
        
        chatImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(25)
        }
        
        chatLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(chatImageView.snp.trailing).offset(10)
            
        }
        
        relatedLabel.snp.makeConstraints{ make in
            make.top.equalTo(chatView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(subtopicLabel)
        }
    }
    
    
}

