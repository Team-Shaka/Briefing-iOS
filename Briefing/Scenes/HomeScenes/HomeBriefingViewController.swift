//
//  HomeBriefingViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/17.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeBriefingViewController: UIViewController {
    private let networkManager = BriefingNetworkManager.shared
    var category: BriefingCategory
    var keywords: Keywords? = nil
    let disposeBag: DisposeBag = DisposeBag()
    
    var briefingUpdateTimeContainer: UIView = UIView()
    
    var briefingUpdateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18, weight: .regular)
        label.textColor = .bfTextGray
        return label
    }()
    
    lazy var fetchKeywordButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.fetchImage, for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(fetchAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    var divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .bfSeperatorGray
        return divider
    }()
    
    lazy var keywordBriefingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 40
        // tableView.tableHeaderView = briefingUpdateTimeContainer
        return tableView
    }()
    
    private var tableViewHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    let refreshControl = UIRefreshControl()
    
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
        bind()
    }
    
    private func configure() {
        briefingUpdateTimeLabel.text = "fetching..."
        keywordBriefingTableView.delegate = self
        keywordBriefingTableView.dataSource = self
        keywordBriefingTableView.register(HomeBriefingTableViewCell.self,
                                          forCellReuseIdentifier: HomeBriefingTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(fetchAction), for: .valueChanged)
        keywordBriefingTableView.refreshControl = refreshControl
        
    }
    
    private func addSubviews() {
        let briefingUpdateTimeContainerSubviews: [UIView] = [fetchKeywordButton,
                                                             briefingUpdateTimeLabel,
                                                             divider]
        
        briefingUpdateTimeContainerSubviews.forEach { subview in
            briefingUpdateTimeContainer.addSubview(subview)
        }
        
        let subviews: [UIView] = [keywordBriefingTableView]
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func makeConstraints() {
        // briefingUpdateTimeContainer.snp.makeConstraints { make in
        //     make.top.equalTo(briefingUpdateTimeLabel)
        //     // make.leading.trailing.equalTo(self.view)
        //     make.bottom.equalTo(divider.snp.bottom)
        // }
        
        briefingUpdateTimeLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        fetchKeywordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.leading.greaterThanOrEqualTo(briefingUpdateTimeLabel.snp.trailing).priority(.low)
            make.width.equalTo(26)
            make.centerY.equalTo(briefingUpdateTimeLabel)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(briefingUpdateTimeLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        keywordBriefingTableView.snp.makeConstraints { make in
            // make.top.equalTo(briefingUpdateTimeContainer.snp.bottom).offset(4)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    private func bind() {

    }
    
    @objc
    private func fetchAction() {
        fetchKeywords()
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
            let briefingWord = BriefingStringCollection.briefing
            self.briefingUpdateTimeLabel.text = "\(keywords.createdAt.dateToString("yyyy.MM.dd (E) a")) \(briefingWord)"
            if let refreshControl = self.keywordBriefingTableView.refreshControl,
                refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            print(keywords)
        } onFailure: { error in
            self.errorHandling(error)
        }
        .disposed(by: disposeBag)
        
    }
    
    private func errorHandling(_ error: Error) {
        print("Error: \(error)")
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
        // let gradient = CAGradientLayer()
        // gradient.frame = briefingUpdateTimeContainer.bounds
        // gradient.locations = [0.0, 0.8]
        // gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        // gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        // gradient.colors = [UIColor.bfWhite.cgColor,
        //                    UIColor.bfWhite.withAlphaComponent(0.0).cgColor]
        return briefingUpdateTimeContainer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = self.keywords?.briefings[safe: indexPath.row]?.id else { return }
        self.navigationController?.pushViewController(BriefingCardViewController(id: id), animated: true)
    }
    
    
}
