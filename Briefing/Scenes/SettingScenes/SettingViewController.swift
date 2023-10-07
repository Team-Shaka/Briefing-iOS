//
//  SettingViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/10/05.
//

import UIKit

enum SettingTableViewCellType {
    case `default`(symbol: UIImage, title: String, value: String?=nil, urlString: String?=nil)
    case button(title: String, color: UIColor = .briefingBlue, authType: SettingAuthType?)
    
    var cellType: SettingTableViewCell.Type {
        switch self {
        case .default: return SettingTableViewDefaultCell.self
        case .button: return SettingTableViewButtonCell.self
        }
    }
}

protocol SettingTableViewCell: UITableViewCell {
    static var identifier: String { get }
}

enum SettingAuthType {
    case signInAndRegister
    case signOut
    case withdrawal
}

class SettingViewController: UIViewController {
    private let authManager = BriefingAuthManager.shared
    
    private lazy var settingCellData: [[SettingTableViewCellType]] = [
        [
            .default(symbol: BriefingImageCollection.Setting.clock,
                     title: BriefingStringCollection.Setting.notiTimeSetting.localized)
        ],
        [
            .default(symbol: BriefingImageCollection.Setting.appVersion,
                     title: BriefingStringCollection.Setting.appVersionTitle.localized,
                     value: BriefingStringCollection.appVersion),
            .default(symbol: BriefingImageCollection.Setting.feedback,
                     title: BriefingStringCollection.Setting.feedbackAndInquiry.localized,
                     urlString: BriefingStringCollection.Link.feedBack.localized),
            .default(symbol: BriefingImageCollection.Setting.versionNote,
                     title: BriefingStringCollection.Setting.versionNote.localized,
                     urlString: BriefingStringCollection.Link.versionNote.localized)
        ],
        [
            .default(symbol: BriefingImageCollection.Setting.termsOfService,
                     title: BriefingStringCollection.Setting.termsOfService.localized,
                     urlString: BriefingStringCollection.Link.termsOfService.localized),
            .default(symbol: BriefingImageCollection.Setting.privacyPolicy,
                     title: BriefingStringCollection.Setting.privacyPolicy.localized,
                     urlString: BriefingStringCollection.Link.privacyPolicy.localized),
            .default(symbol: BriefingImageCollection.Setting.caution,
                     title: BriefingStringCollection.Setting.caution.localized,
                     urlString: BriefingStringCollection.Link.caution.localized)
        ],
        []
    ]
    
    private let authCellSectionInsertIndex: Int = 3
    private var authCellSectionData: [SettingTableViewCellType] {
        if authManager.member != nil {
            return [
                .button(title: BriefingStringCollection.Setting.signOut.localized,
                        authType: .signOut),
                .button(title: BriefingStringCollection.Setting.withdrawal.localized,
                        color: .briefingRed,
                        authType: .withdrawal)
            ]
        } else {
            return [
                .button(title: BriefingStringCollection.Setting.signInAndRegister.localized,
                        authType: .signInAndRegister)
            ]
        }
    }
    
    private var settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 50
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 52
        return tableView
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
        self.settingTableView.register(SettingTableViewButtonCell.self,
                                       forCellReuseIdentifier: SettingTableViewButtonCell.identifier)
    }
    
    private func addSubviews() {
        let subViews: [UIView] = [settingTableView]
        
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        settingTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func selectSignInAndRegister() {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func selectSignOut() {
        // FIXME: - Alert View
        authManager.signOut()
        settingTableView.reloadSections(IndexSet(integer: authCellSectionInsertIndex),
                                        with: .fade)
    }
    
    func selectWithdrawal() {
        // FIXME: - Alert View
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
        return settingCellData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var settingCellData = settingCellData
        settingCellData.insert(authCellSectionData,
                               at: authCellSectionInsertIndex)
        let cellSectionData = settingCellData[indexPath.section]
        
        var cornerMaskEdge: UIRectEdge? = nil
        if indexPath.row == (cellSectionData.count - 1) { cornerMaskEdge = .bottom }
        if indexPath.row == 0 { cornerMaskEdge = cornerMaskEdge == .bottom ? .all : .top }
        
        switch cellSectionData[indexPath.row] {
        case let .default(symbol, title, value, urlString):
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SettingTableViewDefaultCell.identifier) as? SettingTableViewDefaultCell else {
                return UITableViewCell()
            }
            cell.setCellData(symbol: symbol,
                             title: title,
                             value: value,
                             urlString: urlString,
                             cornerMaskEdge: cornerMaskEdge)
            return cell
        case let .button(title, color, _):
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SettingTableViewButtonCell.identifier) as? SettingTableViewButtonCell else {
                return UITableViewCell()
            }
            cell.setCellData(title: title,
                             color: color,
                             cornerMaskEdge: cornerMaskEdge)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var settingCellData = settingCellData
        settingCellData.insert(authCellSectionData,
                               at: authCellSectionInsertIndex)
        let cellSectionData = settingCellData[indexPath.section]
        
        switch  cellSectionData[indexPath.row] {
        case let .default(_, _, _, urlString):
            guard let urlString = urlString else { return }
            self.openURLInSafari(urlString)
        case let .button(_, _, authType):
            guard let authType = authType else { return }
            switch authType {
            case .signInAndRegister: selectSignInAndRegister()
            case .signOut: selectSignOut()
            case .withdrawal: selectWithdrawal()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
