//
//  HomeBriefingViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/17.
//

import UIKit

final class HomeBriefingViewController: UIViewController {
    private let networkManager = BriefingNetworkManager.shared
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
        fetchKeywords()
    }
    
    private func configure() {
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        view.backgroundColor = .briefingWhite
        
        let dateFormat = BriefingStringCollection.Format.dateDotFormat
        let dateString = briefingDate.dateToString(dateFormat)
        let titleLabelText = "\(dateString) \(BriefingStringCollection.keywordBriefing)"
        briefingTitleLabel.text = titleLabelText
        
        let updateTimeDateFormat = BriefingStringCollection.Format.dateDetailDotFormat
        let updateTimeString = Date().dateToString(updateTimeDateFormat,
                                                   localeIdentifier: BriefingStringCollection.Locale.en)
        let updateTimeLabelText = "\(BriefingStringCollection.updated): \(updateTimeString)"
        briefingUpdateTimeLabel.text = updateTimeLabelText
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
    
    private func fetchKeywords(){
        print(briefingDate.dateToString())
        networkManager.fetchKeywords(date: briefingDate,
                                     type: .korea) { value, error in
           
            print(value, error)
        }
    }
    
}
