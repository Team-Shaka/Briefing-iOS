//
//  MainBriefingViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/17.
//

import UIKit

final class MainBriefingViewController: UIViewController {
    var briefingDate: Date
    
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
    
    init(briefingDate: Date) {
        self.briefingDate = briefingDate
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
    }
    
    private func configure() {
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        view.backgroundColor = .briefingWhite
        
        briefingTitleLabel.text = "\(briefingDate.dateToString()) 키워드 브리핑"
        briefingUpdateTimeLabel.text = "Updated: 00.00.00 0AM"
    }
    
    private func addSubviews() {
        let subViews: [UIView] = [briefingTitleLabel,
                                  briefingUpdateTimeLabel]
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
    }
    
}
