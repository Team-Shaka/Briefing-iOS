//
//  SettingTimePickCell.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import UIKit

class SettingTimePickCell: UITableViewCell {
    static let cellID = "SettingTimePickCell"
    
    let layout_main = UIView()
    
    let layout_image = UIImageView()
    let label_title = UILabel()
    let label_timePick = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .mainGray
        self.contentView.addSubview(layout_main)
        
        layout_main.snp.makeConstraints{ make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        layout_main.backgroundColor = .white
//        layout_main.layer.cornerRadius = self.frame.width * 0.11
        
        layout_main.addSubviews(layout_image, label_title, label_timePick)
        
        layout_image.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(26)
        }
        
        layout_image.image = UIImage(named: "setting_clock")
        
        label_title.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(layout_image.snp.trailing).offset(10)
        }
        
        label_title.text = "알림 시간 설정"
        label_title.textAlignment = .left
        label_title.textColor = .mainBlue
        label_title.font = UIFont(name: "ProductSans-Regular", size: 17)
        label_title.numberOfLines = 1
        
        label_timePick.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        label_timePick.text = "오전 9시"
        label_timePick.textAlignment = .right
        label_timePick.textColor = .thirdBlue
        label_timePick.font = UIFont(name: "ProductSans-Regular", size: 17)
        label_timePick.numberOfLines = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timePickTapped))
        tapGesture.delegate = self
        label_timePick.addGestureRecognizer(tapGesture)
        label_timePick.isUserInteractionEnabled = true
    }
    
    @objc func timePickTapped() {
        print("timePick tapped")
    }
}

class SettingTextInfoCell: UITableViewCell {
    static let cellID = "SettingTextInfoCell"
    
    let layout_main = UIView()
    
    let layout_image = UIImageView()
    let label_title = UILabel()
    let label_info = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .mainGray
        self.contentView.addSubview(layout_main)
        
        layout_main.snp.makeConstraints{ make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        layout_main.backgroundColor = .white
        //        layout_main.layer.cornerRadius = self.frame.width * 0.11
        
        layout_main.addSubviews(layout_image, label_title, label_info)
        
        layout_image.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(26)
        }
        
        layout_image.image = UIImage(named: "setting_version")
        
        label_title.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(layout_image.snp.trailing).offset(10)
        }
        
        label_title.text = "앱 버전"
        label_title.textAlignment = .left
        label_title.textColor = .mainBlue
        label_title.font = UIFont(name: "ProductSans-Regular", size: 17)
        label_title.numberOfLines = 1
        
        label_info.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        label_info.text = "1.0.0"
        label_info.textAlignment = .right
        label_info.textColor = .mainBlue
        label_info.font = UIFont(name: "ProductSans-Regular", size: 17)
        label_info.numberOfLines = 1
        
    }
}

class SettingDetailCell: UITableViewCell {
    static let cellID = "SettingDetailCell"
    
    let layout_main = UIView()
    
    var titleText = ""
    
    var layout_image = UIImageView()
    var label_title = UILabel()
    let button_details = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .mainGray
        self.contentView.addSubview(layout_main)
        
        layout_main.snp.makeConstraints{ make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        layout_main.backgroundColor = .white
//        layout_main.layer.cornerRadius = self.frame.width * 0.11
        
        layout_main.addSubviews(layout_image, label_title, button_details)
        
        layout_image.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(26)
        }
        
        layout_image.image = UIImage(named: "setting_feedback")
        
        label_title.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(layout_image.snp.trailing).offset(10)
        }
        
        label_title.text = titleText
        label_title.textAlignment = .left
        label_title.textColor = .mainBlue
        label_title.font = UIFont(name: "ProductSans-Regular", size: 17)
        label_title.numberOfLines = 1
        
        button_details.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        button_details.setImage(UIImage(named: "details"), for: .normal)
        button_details.addTarget(self, action: #selector(detailsTapped), for: .touchUpInside)
    }
    
    @objc func detailsTapped() {
        print("details tapped")
    }
}
