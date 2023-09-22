//
//  BriefingCardViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/19.
//

import UIKit
import SnapKit

class BriefingCardViewController: UIViewController {
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Briefing #()"
        label.font = .productSans(size: 24)
        label.textColor = .briefingWhite
        return label
    }()
    
    private var scrapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "scrap_normal"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var cardView: UIView = {
        let view = UIView()        
        return view
    }()
    
    private var cardTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraint()
    }
    
    private func configure() {
        self.view.backgroundColor = .briefingBlue
        cardTableView.register(BriefingCardCell.self, forCellReuseIdentifier: BriefingCardCell.identifier)
        cardTableView.dataSource = self
        cardTableView.delegate = self
    }
    
    private func addSubviews() {
        self.view.addSubviews(navigationView, cardView)
        
        self.navigationView.addSubviews(backButton, titleLabel, scrapButton)
        
        self.cardView.addSubviews(cardTableView)
    }
    
    private func makeConstraint() {
        navigationView.snp.makeConstraints{ make in
//            make.top.equalTo(view).offset(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.bottom.equalTo(titleLabel).offset(25)
            make.leading.trailing.equalTo(view)
        }
        
        backButton.snp.makeConstraints{ make in
            make.centerY.equalTo(navigationView)
            make.height.equalTo(navigationView)
            make.width.equalTo(backButton.snp.height)
            make.leading.equalTo(navigationView).inset(28)
        }
        
        titleLabel.snp.makeConstraints{ make in
//            make.top.equalTo(navigationView).offset(6)
            make.centerY.equalTo(navigationView)
            make.centerX.equalTo(navigationView)
            make.trailing.lessThanOrEqualTo(scrapButton)
        }
        
        scrapButton.snp.makeConstraints{ make in
            make.centerY.equalTo(navigationView)
            make.height.equalTo(navigationView)
            make.width.equalTo(scrapButton.snp.height)
            make.trailing.equalTo(navigationView).inset(18)
        }
        
        cardView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        cardTableView.snp.makeConstraints{ make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension BriefingCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BriefingCardCell.identifier, for: indexPath) as! BriefingCardCell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cardTableView.bounds.height
    }
    
}
