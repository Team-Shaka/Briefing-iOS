//
//  ScrapbookViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 11/2/23.
//

import UIKit
import SnapKit

class ScrapbookViewController: UIViewController {
    private let networkManager = BriefingNetworkManager.shared
    
    var scrapData: [(Date?, [ScrapData?])] = [(nil, [nil])]
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_blue"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(goBackToHomeViewController), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.Scrapbook.scrapbookTitle.localized
        label.font = .productSans(size: 24)
        label.textColor = .briefingNavy
        return label
    }()
    
    private var scrapTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 50
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 52
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraint()
        fetchScrapbook()
    }
    
    private func configure() {
        self.view.backgroundColor = .briefingWhite
        
//        self.scrapTableView.delegate = self
//        self.scrapTableView.dataSource = self
//        self.scrapTableView.register(ScrapbookTableViewCell.self, forCellReuseIdentifier: ScrapbookTableViewCell.identifier)
        
        addSwipeGestureToDismiss()
    }
    
    private func addSubviews() {
        navigationView.addSubviews(backButton, titleLabel)
        
        self.view.addSubviews(navigationView, scrapTableView)
    }
    
    private func makeConstraint() {
        navigationView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
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
        
        scrapTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func fetchScrapbook() {
        networkManager.fetchScrapBrifings() { [weak self] value, error in
            guard let self = self else  { return }
            if let error = error {
                self.errorHandling(error)
                return
            }
            
            guard let scrapData = value else { return }
            
            self.scrapData = scrapData
            
            print(self.scrapData.count)
            
        }
    }
    
    private func errorHandling(_ error: Error) {
        print("error: \(error)")
    }
    
    @objc func goBackToHomeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//extension ScrapbookViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
