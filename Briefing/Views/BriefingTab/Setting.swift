//
//  Setting.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import UIKit

class Setting: UIViewController {
    private let section_noti: [String] = ["알림 시간 설정"]
    private let section_info: [String] = ["앱 버전", "피드백 및 문의하기", "버전 노트"]
    private let section_warning: [String] = ["이용 약관", "개인정보처리방침", "유의사항"]
//    private let section_user: [String] = ["로그아웃", "회원 탈퇴"]
    
//    private let sections: [String] = ["noti", "info", "warn", "user"]
    private let sections: [String] = ["noti", "info", "warn"]
    
    let layout_nav = UIView()
    
    lazy var layout_table: UITableView = {
        // Get the height of the Status Bar.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            
        // Get the height and width of the View.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
            
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight), style: .insetGrouped)
            
        // Register the Cell name.
        tableView.register(SettingTimePickCell.self, forCellReuseIdentifier: SettingTimePickCell.cellID)
        tableView.register(SettingTextInfoCell.self, forCellReuseIdentifier: SettingTextInfoCell.cellID)
        tableView.register(SettingDetailCell.self, forCellReuseIdentifier: SettingDetailCell.cellID)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NotiCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TextCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailsCell")
            
        // Set the DataSource.
        tableView.dataSource = self
            
        // Set Delegate.
        tableView.delegate = self
        
        tableView.backgroundColor = .mainGray
            
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainGray
        
        navigationController?.isNavigationBarHidden = true
        
        setNav()
        setTable()
    }
    
    private func setNav() {
        let label_title = UILabel()
        let button_back = UIButton()
        
        self.view.addSubview(layout_nav)
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.159)
        }
        
        layout_nav.addSubviews(label_title, button_back)
        
        label_title.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(15)
        }
        
        label_title.text = "설정"
        label_title.textColor = .mainBlue
        label_title.font = UIFont(name: "ProductSans-Regular", size: 24)
        label_title.textAlignment = .center
        label_title.numberOfLines = 1
        
        button_back.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.leading.equalToSuperview().offset(self.view.frame.width * 0.076)
            make.width.height.equalTo(25)
        }
        
        button_back.setImage(UIImage(named: "arrow_blue"), for: .normal)
        button_back.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setTable() {
        self.view.addSubview(layout_table)
        
        layout_table.snp.makeConstraints{ make in
            make.top.equalTo(layout_nav.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // Returns the number of sections.
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

extension Setting {
    @objc func backButtonTapped() {
        print("setting -> home")
        self.navigationController?.popViewController(animated: true)
    }
}

extension Setting: UITableViewDelegate, UITableViewDataSource {
    // Returns the title of the section.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }

    // Called when Cell is selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Value: \(section_noti[indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(section_info[indexPath.row])")
        } else if indexPath.section == 2 {
            print("Value: \(section_warning[indexPath.row])")
        }
//        else if indexPath.section == 2 {
//            print("Value: \(section_user[indexPath.row])")
//        }
        else {
            return
        }
    }
        
    // Returns the total number of arrays to display in the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section_noti.count
        } else if section == 1 {
            return section_info.count
        } else if section == 2 {
            return section_warning.count
        }
//        else if section == 3 {
//            return section_user.count
//        }
        else {
            return 0
        }
    }
        
    // Set a value in Cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotiCell", for: indexPath)
        
        let timePickCell = tableView.dequeueReusableCell(withIdentifier: "SettingTimePickCell", for: indexPath)
        let textInfoCell = tableView.dequeueReusableCell(withIdentifier: "SettingTextInfoCell", for: indexPath)
        
//        let tapGestureTimePick = UITapGestureRecognizer(target: self, action: #selector(openTimePicker))
//        timePickCell.contentView.addGestureRecognizer(tapGestureTimePick)
        
        if indexPath.section == 0 {
            return timePickCell
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return textInfoCell
            } else if indexPath.row == 1 {
                if let detailsCell = tableView.dequeueReusableCell(withIdentifier: "SettingDetailCell", for: indexPath) as? SettingDetailCell {
                    detailsCell.layout_image.image = UIImage(named: "setting_feedback")
                    detailsCell.label_title.text = "피드백 및 문의하기"
       
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openFeedback))
                    detailsCell.contentView.addGestureRecognizer(tapGesture)
                    
                    return detailsCell
                }
            } else if indexPath.row == 2 {
                if let detailsCell = tableView.dequeueReusableCell(withIdentifier: "SettingDetailCell", for: indexPath) as? SettingDetailCell {
                    detailsCell.layout_image.image = UIImage(named: "setting_version_note")
                    detailsCell.label_title.text = "버전 노트"
//                    detailsCell.button_details.addTarget(self, action: #selector(openVersionNotes), for: .touchUpInside)
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openVersionNotes))
                    detailsCell.contentView.addGestureRecognizer(tapGesture)
                    
                    return detailsCell
                }
            } else {
                return cell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                if let detailsCell = tableView.dequeueReusableCell(withIdentifier: "SettingDetailCell", for: indexPath) as? SettingDetailCell {
                    detailsCell.layout_image.image = UIImage(named: "setting_policy")
                    detailsCell.label_title.text = "이용 약관"
//                    detailsCell.button_details.addTarget(self, action: #selector(openUserPolicies), for: .touchUpInside)
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openUserPolicies))
                    detailsCell.contentView.addGestureRecognizer(tapGesture)
                    
                    return detailsCell
                }
            } else if indexPath.row == 1 {
                if let detailsCell = tableView.dequeueReusableCell(withIdentifier: "SettingDetailCell", for: indexPath) as? SettingDetailCell {
                    detailsCell.layout_image.image = UIImage(named: "setting_policy")
                    detailsCell.label_title.text = "개인정보처리방침"
//                    detailsCell.button_details.addTarget(self, action: #selector(openPrivacyPolicies), for: .touchUpInside)
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPrivacyPolicies))
                    detailsCell.contentView.addGestureRecognizer(tapGesture)
                    
                    return detailsCell
                }
            } else if indexPath.row == 2 {
                if let detailsCell = tableView.dequeueReusableCell(withIdentifier: "SettingDetailCell", for: indexPath) as? SettingDetailCell {
                    detailsCell.layout_image.image = UIImage(named: "setting_caution")
                    detailsCell.label_title.text = "유의사항"
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openWarnings))
                    detailsCell.contentView.addGestureRecognizer(tapGesture)
                    
                    return detailsCell
                }
            } else {
                return cell
            }
        }
//        else if indexPath.section == 3 {
//            cell.textLabel?.text = "\(section_user[indexPath.row])"
//            cell.textLabel?.textColor = .textGray
//            cell.isUserInteractionEnabled = false
//            return cell
//        }
        else {
            return UITableViewCell()
        }
            
        return cell
    }
}
