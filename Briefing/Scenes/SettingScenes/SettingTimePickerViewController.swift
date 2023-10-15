//
//  SettingTimePickerViewController.swift
//  Briefing
//
//  Created by 이전희 on 10/10/23.
//

import UIKit

protocol SettingTimePickerViewControllerDelegate {
    func setTime(_ time: NotificationTime)
    func removeTime()
}

class SettingTimePickerViewController: UIViewController {
    var delegate: SettingTimePickerViewControllerDelegate?
    var meridiem: Int = 0
    var hour: Int = 0
    var minutes: Int = 0
    
    private var timePickerLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.Setting.notificationTimeSetting.localized
        label.font = .productSans(size: 22, weight: .bold)
        label.textColor = .briefingNavy
        return label
    }()
    
    private var timePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private var setNotificationTimeButton: UIButton = {
        let configuration = UIButton.Configuration
            .BriefingButtonConfiguration(title: BriefingStringCollection.Setting.setNotification.localized,
                                         foregroundColor: .briefingWhite,
                                         backgroundColor: .briefingNavy)
        return UIButton(configuration: configuration)
    }()
    
    private var removeNotificationTimeButton: UIButton = {
        let configuration = UIButton.Configuration
            .BriefingButtonConfiguration(title: BriefingStringCollection.Setting.removeNotification.localized,
                                         foregroundColor: .briefingRed,
                                         backgroundColor: .clear)
        return UIButton(configuration: configuration)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.detents = [.medium()]
        }
        configure()
        addSubviews()
        makeConstraints()
    }
    
    private func configure() {
        timePickerView.delegate = self
        setNotificationTimeButton.addTarget(self, 
                                            action: #selector(setNotificationButtonAction),
                                            for: .touchUpInside)
        
        removeNotificationTimeButton.addTarget(self,
                                            action: #selector(removeNotificationButtonAction),
                                            for: .touchUpInside)
    }
    
    private func addSubviews() {
        [timePickerLabel, timePickerView, setNotificationTimeButton, removeNotificationTimeButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func makeConstraints() {
        timePickerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.equalToSuperview().offset(36)
            make.trailing.equalToSuperview().inset(36)
        }
        
        timePickerView.snp.makeConstraints { make in
            make.top.equalTo(timePickerLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        setNotificationTimeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        removeNotificationTimeButton.snp.makeConstraints { make in
            make.top.equalTo(setNotificationTimeButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(52)
        }
    }
    
    func setTime(time: NotificationTime?) {
        self.meridiem = time?.meridiem ?? 0
        self.hour = time?.hour ?? 12
        self.minutes = time?.minutes ?? 0
    }
    
    @objc func setNotificationButtonAction() {
        self.delegate?.setTime(NotificationTime(meridiem: meridiem, hour: hour, minutes: minutes))
        self.dismiss(animated: true)
    }
    
    @objc func removeNotificationButtonAction() {
        self.delegate?.removeTime()
        self.dismiss(animated: true)
    }
}

extension SettingTimePickerViewController: UIPickerViewDelegate,
                                           UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return 1 // AM; 2: (AM, PM)
        case 1: return 12 - 3 // 04-12; 12 (01-12)
        case 2: return 60
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var rowText = ""
        switch component {
        case 0:
            rowText = row == 0 ? "AM" : "PM"
            print(pickerView.selectedRow(inComponent: 1))
            if pickerView.selectedRow(inComponent: 1) == (12 - 4) { rowText = "PM" } // 04-12
        case 1: rowText = String(format: "%02d", row+1 + 3)
        case 2: rowText = String(format: "%02d", row)
        default: break
        }
        return NSAttributedString(string: "\(rowText)", attributes: [.font: UIFont.productSans(size: 14),
                                                                 .foregroundColor: UIColor.briefingNavy])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: self.meridiem = row
        case 1:
            self.hour = row + 1 + 3
            if (row + 1 + 3) == 12 { pickerView.reloadComponent(0) } // 04-12
        case 2: self.minutes = row
        default: break
        }
    }
}
