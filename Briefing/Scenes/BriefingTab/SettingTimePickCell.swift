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
    
    let picker_time: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let hours = Array(5...12)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        
        picker_time.delegate = self
        picker_time.dataSource = self
        
        if let savedHour = UserDefaults.standard.value(forKey: "selectedHour") as? Int,
           let index = hours.firstIndex(of: savedHour) {
            picker_time.selectRow(index, inComponent: 0, animated: false)
        }
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
        
        layout_main.addSubviews(layout_image, label_title, picker_time)
        
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
        
        picker_time.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.width.equalTo(self.contentView.frame.width * 0.3)
        }

    }

}

extension SettingTimePickCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (hours[row] == 12) {
            return "오후 \(hours[row])시"
        } else {
            return "오전 \(hours[row])시"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedHour = hours[row]
        print("Selected hour: \(selectedHour)")
        scheduleNotification(at: selectedHour)
        UserDefaults.standard.set(selectedHour, forKey: "selectedHour")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()

        
        
        if (hours[row] == 12) {
            pickerLabel.text = "오후 \(hours[row])시"
        } else {
            pickerLabel.text = "오전 \(hours[row])시"
        }
        
        pickerLabel.textAlignment = .center
        pickerLabel.backgroundColor = .clear
        pickerLabel.textColor = .thirdBlue
        pickerLabel.font = UIFont(name: "ProductSans-Regular", size: 17) // 글꼴 및 크기

        return pickerLabel
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
