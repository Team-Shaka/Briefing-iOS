//
//  BriefingCardViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/19.
//

import UIKit
import SnapKit

class BriefingCardViewController: UIViewController {
    private var id: Int
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_left"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(goBackToHomeViewController), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
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
    
    private var cardScrollView: UIView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.addShadow(offset: CGSize(width: 0, height: 4),
                       color: .black,
                       radius: 5,
                       opacity: 0.1)
        return view
    }()
//
//    private var cardTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//
//        return tableView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraint()
    }
    
    init(id: Int){
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.view.backgroundColor = .briefingBlue
//        cardTableView.register(BriefingCardCell.self, forCellReuseIdentifier: BriefingCardCell.identifier)
//        cardTableView.dataSource = self
//        cardTableView.delegate = self
        self.titleLabel.text = "\(BriefingStringCollection.appName) #\(self.id)"
    }
    
    private func addSubviews() {
        self.view.addSubviews(navigationView, cardScrollView)
        
        self.navigationView.addSubviews(backButton, titleLabel, scrapButton)
        
        self.cardScrollView.addSubview(cardView)
        
//        self.cardView.addSubviews(cardTableView)
    }
    
    private func makeConstraint() {
        navigationView.snp.makeConstraints{ make in
//            make.top.equalTo(view).offset(50)
            make.top.equalTo(view.safeAreaLayoutGuide)
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
        
        cardScrollView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        cardView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().inset(17)
//            make.bottom
            
//            make.height.equalTo(1000)
        }
//
//        cardTableView.snp.makeConstraints{ make in
//            make.top.leading.trailing.bottom.equalToSuperview()
//        }
        
        
    }
    
    @objc func goBackToHomeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}

//extension BriefingCardViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: BriefingCardCell.identifier, for: indexPath) as! BriefingCardCell
//
//
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return cardTableView.bounds.height
//    }
//
//}
