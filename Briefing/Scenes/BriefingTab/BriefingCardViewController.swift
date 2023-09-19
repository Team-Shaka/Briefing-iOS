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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraint()
    }
    
    private func configure() {
        self.view.backgroundColor = .briefingBlue
    }
    
    private func addSubviews() {
        self.view.addSubviews(navigationView)
        
        self.navigationView.addSubviews(backButton, titleLabel, scrapButton)
        
        
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
    }
}
