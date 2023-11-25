//
//  HomeBriefingViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/17.
//

import UIKit
import RxSwift

final class HomeBriefingViewController: UIViewController {
    private let networkManager = BriefingNetworkManager.shared
    var category: BriefingCategory
    var keywords: Keywords? = nil
    let disposeBag: DisposeBag = DisposeBag()
    
    var briefingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 26, weight: .bold)
        label.textColor = .briefingNavy
        return label
    }()
    
    var briefingUpdateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 12, weight: .regular)
        label.textColor = .briefingLightBlue
        return label
    }()
    
    var keywordBriefingTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 14
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    private var tableViewHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(category: BriefingCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
        fetchKeywords()
    }
    
    private func configure() {
        briefingUpdateTimeLabel.text = "briefingUpdateTimeLabel"
        keywordBriefingTableView.delegate = self
        keywordBriefingTableView.dataSource = self
        keywordBriefingTableView.register(HomeBriefingTableViewCell.self,
                                          forCellReuseIdentifier: HomeBriefingTableViewCell.identifier)
        
    }
    
    private func addSubviews() {
        let subViews: [UIView] = [briefingTitleLabel,
                                  briefingUpdateTimeLabel,
                                  keywordBriefingTableView]
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        briefingTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(22)
            make.trailing.lessThanOrEqualToSuperview().offset(22)
        }
        
        briefingUpdateTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(briefingTitleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(22)
            make.trailing.lessThanOrEqualToSuperview().offset(22)
        }
        
        keywordBriefingTableView.snp.makeConstraints { make in
            make.top.equalTo(briefingUpdateTimeLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func fetchKeywords() {
        networkManager.fetchKeywords(date: Date(),
                                     type: category.keywordType)
        .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
        .observe(on: MainScheduler.asyncInstance)
        .subscribe { [weak self] keywords in
            guard let self = self else { return }
            self.keywords = keywords
            self.keywordBriefingTableView.reloadData()
        } onFailure: { error in
            self.errorHandling(error)
        }
        .disposed(by: disposeBag)

    }
    
    private func errorHandling(_ error: Error) {
        
    }
}

extension HomeBriefingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keywords?.briefings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBriefingTableViewCell.identifier) as? HomeBriefingTableViewCell,
              let keywordBriefing = keywords?.briefings[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.updateKeywordBriefing(keywordBriefing)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let gradient = CAGradientLayer()
        gradient.frame = tableViewHeaderView.bounds
        gradient.locations = [0.0, 0.8]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = [UIColor.bfWhite.cgColor,
                           UIColor.bfWhite.withAlphaComponent(0.0).cgColor]
        tableViewHeaderView.layer.addSublayer(gradient)
        return tableViewHeaderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = self.keywords?.briefings[safe: indexPath.row]?.id else { return }
        self.navigationController?.pushViewController(BriefingCardViewController(id: id), animated: true)
    }
}
