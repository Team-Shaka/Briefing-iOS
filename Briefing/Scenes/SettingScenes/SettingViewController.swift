//
//  SettingViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/05.
//

import UIKit

enum SettingTableViewCellType {
    case `default`(title: String, type: SettingTableViewDefaultCellType)
    case auth(title: String, color: UIColor = .black, type: SettingTableViewAuthCellType)
}

enum SettingTableViewDefaultCellType {
    case text(_ text: String)
    case url(_ urlString: String)
    case customView(_ view: UIView)
}

enum SettingTableViewAuthCellType {
    case signInAndRegister
    case signOut
    case withdrawal
}

class SettingViewController: UIViewController {
    private let authManager = BriefingAuthManager.shared
    private let notificationManager = BriefingNotificationManager.shared
    
    @UserDefaultWrapper(key: .notificationTime, defaultValue: nil)
    var notificationTime: NotificationTime?
    
    private lazy var settingCellData: [(String, [SettingTableViewCellType])] = [
        (BriefingStringCollection.Setting.notification.localized, [
            .default(title: BriefingStringCollection.Setting.notificationTimeSetting.localized,
                     type: .customView(self.notificationTimePickerButton))
        ]),
        (BriefingStringCollection.Setting.appInfo.localized,[
            .default(title: BriefingStringCollection.Setting.appVersionTitle.localized,
                     type: .text(BriefingStringCollection.appVersion)),
            .default(title: BriefingStringCollection.Setting.feedbackAndInquiry.localized,
                     type: .url(BriefingStringCollection.Link.feedBack.localized)),
            .default(title: BriefingStringCollection.Setting.versionNote.localized,
                     type: .url(BriefingStringCollection.Link.versionNote.localized))
        ]),
        (BriefingStringCollection.Setting.support.localized, [
            .default(title: BriefingStringCollection.Setting.termsOfService.localized,
                     type: .url(BriefingStringCollection.Link.termsOfService.localized)),
            .default(title: BriefingStringCollection.Setting.privacyPolicy.localized,
                     type: .url(BriefingStringCollection.Link.privacyPolicy.localized)),
            .default(title: BriefingStringCollection.Setting.caution.localized,
                     type: .url(BriefingStringCollection.Link.caution.localized))
        ]),
        ("", [])
    ]
    
    private let authCellSectionInsertIndex: Int = 3
    private var authCellSectionData: (String, [SettingTableViewCellType]) {
        if authManager.member != nil {
            return (BriefingStringCollection.Setting.account.localized, [
                .auth(title: BriefingStringCollection.Setting.signOut.localized,
                      type: .signOut),
                .auth(title: BriefingStringCollection.Setting.withdrawal.localized,
                      color: .briefingRed,
                      type: .withdrawal)
            ])
        } else {
            return (BriefingStringCollection.Setting.account.localized,[
                .auth(title: BriefingStringCollection.Setting.signInAndRegister.localized,
                      type: .signInAndRegister)
            ])
        }
    }
    
    private var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.backIconImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(goBackToHomeViewController), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.Setting.settings.localized
        label.font = .productSans(size: 24)
        label.textColor = .briefingNavy
        return label
    }()
    
    private var settingTableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: UITableView.Style.grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 50
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var notificationTimePickerButton: UIButton = {
        // var configuration = UIButton.Configuration.filled()
        // configuration.baseBackgroundColor = .briefingLightBlue.withAlphaComponent(0.4)
        let button = UIButton()
        button.setTitle("_", for: .normal)
        button.setTitleColor(.briefingNavy, for: .normal)
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        settingTableView.reloadSections(IndexSet(integer: authCellSectionInsertIndex),
                                        with: .fade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
    }
    
    private func configure() {
        self.view.backgroundColor = .briefingWhite
        
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        self.settingTableView.register(SettingTableViewDefaultCell.self,
                                       forCellReuseIdentifier: SettingTableViewDefaultCell.identifier)
        self.settingTableView.register(SettingTableViewAuthCell.self,
                                       forCellReuseIdentifier: SettingTableViewAuthCell.identifier)
        self.settingTableView.tableFooterView =
        UIView(frame: CGRect(origin: .zero,
                             size: CGSize(width:CGFloat.leastNormalMagnitude,
                                          height: CGFloat.leastNormalMagnitude)))
        
        self.notificationTimePickerButton.addTarget(self, action: #selector(showTimePickerView(_:)), for: .touchUpInside)
        let notificationTime = self.notificationTime?.toString() ?? BriefingStringCollection.Setting.setting.localized
        self.notificationTimePickerButton.setTitle(notificationTime, for: .normal)
        addSwipeGestureToDismiss()
    }
    
    private func addSubviews() {
        [backButton, titleLabel].forEach { subView in
            navigationView.addSubview(subView)
        }
        
        [navigationView, settingTableView].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(titleLabel).offset(25)
            make.leading.trailing.equalTo(view)
        }
        
        backButton.snp.makeConstraints{ make in
            make.centerY.equalTo(navigationView)
            make.height.equalTo(titleLabel)
            make.width.equalTo(backButton.snp.height)
            make.leading.equalTo(navigationView).inset(21)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(navigationView)
            make.centerX.equalTo(navigationView)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func selectSignInAndRegister() {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func selectSignOut() {
        let title = BriefingStringCollection.Setting.signOut.localized
        let description = BriefingStringCollection.Setting.signOutDescription.localized
        let cancel = BriefingStringCollection.cancel
        let popupViewController = BriefingPopUpViewController(index: 0,
                                                              title: title,
                                                              description: description,
                                                              buttonTitles:[cancel, title],
                                                              style: .twoButtonsDestructive)
        popupViewController.modalPresentationStyle = .overFullScreen
        popupViewController.delegate = self
        self.present(popupViewController, animated: false)
    }
    
    func selectWithdrawal() {
        let title = BriefingStringCollection.Setting.withdrawal.localized
        let description = BriefingStringCollection.Setting.withdrawalDescription.localized
        let cancel = BriefingStringCollection.cancel
        let popupViewController = BriefingPopUpViewController(index: 1,
                                                              title: title,
                                                              description: description,
                                                              buttonTitles:[cancel, title],
                                                              style: .twoButtonsDestructive)
        popupViewController.modalPresentationStyle = .overFullScreen
        popupViewController.delegate = self
        self.present(popupViewController, animated: false)
    }

    func showErrorMessage(message: String) {
        let title = BriefingStringCollection.Setting.withdrawal.localized
        let confirm = BriefingStringCollection.confirm
        let popupViewController = BriefingPopUpViewController(index: 1,
                                                              title: title,
                                                              description: message,
                                                              buttonTitles:[confirm],
                                                              style: .normal)
        popupViewController.modalPresentationStyle = .overFullScreen
        popupViewController.delegate = self
        self.present(popupViewController, animated: false)
    }
    
    @objc func goBackToHomeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingCellData.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var settingCellData = settingCellData
        settingCellData.insert(authCellSectionData,
                               at: authCellSectionInsertIndex)
        return settingCellData[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var settingCellData = settingCellData
        settingCellData.insert(authCellSectionData,
                               at: authCellSectionInsertIndex)
        let cellSectionData = settingCellData[indexPath.section].1
        
        switch cellSectionData[indexPath.row] {
        case let .default(title, type):
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SettingTableViewDefaultCell.identifier) as? SettingTableViewDefaultCell else {
                return UITableViewCell()
            }
            cell.setCellData(title: title,
                             type: type)
            return cell
        case let .auth(title, color, _):
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SettingTableViewAuthCell.identifier) as? SettingTableViewAuthCell else {
                return UITableViewCell()
            }
            cell.setCellData(title: title,
                             color: color)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var settingCellData = settingCellData
        settingCellData.insert(authCellSectionData,
                               at: authCellSectionInsertIndex)
        let cellSectionData = settingCellData[indexPath.section].1
        
        switch  cellSectionData[indexPath.row] {
        case let .default(_, type):
            switch type {
            case let .url(urlString):
                self.openURLInSafari(urlString)
            default: break
            }
        case let .auth(_, _, type):
            switch type {
            case .signInAndRegister: selectSignInAndRegister()
            case .signOut: selectSignOut()
            case .withdrawal: selectWithdrawal()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var settingCellData = settingCellData
        settingCellData.insert(authCellSectionData,
                               at: authCellSectionInsertIndex)
        let cellSectionHeaderTitle = settingCellData[section].0
        return SettingTableViewSectionHeaderView(title: cellSectionHeaderTitle)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return .leastNormalMagnitude
    }
    
    @objc func showTimePickerView(_ sender: UIButton) {
        //MARK: TODO: 권한 체크 후 분기 필요
        notificationManager.isNotificationPermissionGranted{ (isGranted) in
            if !isGranted {
                //MARK: - 권한 설정 안 되어있으면 삭제 처리 해줌
                self.notificationTime = nil
                let notificationTime = self.notificationTime?.toString() ?? BriefingStringCollection.Setting.setting.localized
                
                self.notificationManager.removeScheduledNotification()
                //MARK: -
                
                let title = BriefingStringCollection.Setting.notificationTime.localized
                let description = BriefingStringCollection.Setting.notificationTurnedOff.localized
                let confirm = BriefingStringCollection.confirm
                let popupViewController = BriefingPopUpViewController(index: 0,
                                                                      title: title,
                                                                      description: description,
                                                                      buttonTitles:[confirm],
                                                                      style: .normal)
                DispatchQueue.main.async {
                    //MARK: Button도 시간 삭제 처리
                    self.notificationTimePickerButton.setTitle(notificationTime, for: .normal)
                    popupViewController.modalPresentationStyle = .overFullScreen
                    popupViewController.delegate = self
                    self.present(popupViewController, animated: false)
                }
                
            }
            else {
                DispatchQueue.main.async {
                    let viewController = SettingTimePickerViewController(self.notificationTime)
                    viewController.delegate = self
                    self.present(viewController, animated: true)
                }
            }
        }
    }
}

extension SettingViewController: SettingTimePickerViewControllerDelegate {
    func setTime(_ time: NotificationTime) {
        self.notificationTime = time
        let notificationTime = self.notificationTime?.toString() ?? BriefingStringCollection.Setting.setting.localized
        self.notificationTimePickerButton.setTitle(notificationTime, for: .normal)
        
        if let notiTime = self.notificationTime {
            notificationManager.scheduleNotification(notificationTime: notiTime)
        }
    }
    
    func removeTime() {
        self.notificationTime = nil
        let notificationTime = self.notificationTime?.toString() ?? BriefingStringCollection.Setting.setting.localized
        self.notificationTimePickerButton.setTitle(notificationTime, for: .normal)
        
        notificationManager.removeScheduledNotification()
    }
}

extension SettingViewController: BriefingPopUpDelegate {
    func cancelButtonTapped(_ popupViewController: BriefingPopUpViewController) { }
    
    func confirmButtonTapped(_ popupViewController: BriefingPopUpViewController) {
        switch popupViewController.index {
        case 0:
            authManager.signOut()
            let indexSet = IndexSet(integer: self.authCellSectionInsertIndex)
            settingTableView.reloadSections(indexSet,
                                            with: .fade)
        case 1:
            authManager.withdrawal { [weak self] result, error in
                guard let self = self else { return }
                if let error = error as? BFNetworkError {
                    switch error {
                    case let .requestFail(_, message):
                        self.showErrorMessage(message: message)
                        return
                    default: break
                    }
                }
                let indexSet = IndexSet(integer: self.authCellSectionInsertIndex)
                self.settingTableView.reloadSections(indexSet,
                                                     with: .fade)
            }
            break
        default: break
        }
    }
}
