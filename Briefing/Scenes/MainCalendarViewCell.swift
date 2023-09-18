//
//  MainCalendarCell.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/16.
//

import UIKit
import SnapKit
import FSCalendar

class MainCalendarCell: FSCalendarCell {
    static let identifier: String = String(describing: MainCalendarCell.self)
    var date: Date = Date()
    
    var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 14)
        label.textAlignment = .center
        return label
    }()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.shapeLayer.isHidden = true
        self.titleLabel.removeFromSuperview()
        self.subtitleLabel.removeFromSuperview()
        contentView.layer.cornerRadius = 5
    }
    
    private func addSubviews() {
        contentView.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
        let subViews: [UIView] = [dayOfWeekLabel, dayLabel]
        subViews.forEach { subView in
            contentView.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        dayOfWeekLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).inset(6)
            make.leading.lessThanOrEqualTo(contentView)
            make.trailing.lessThanOrEqualTo(contentView)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(dayOfWeekLabel.snp.bottom).offset(6)
            make.leading.lessThanOrEqualTo(contentView)
            make.trailing.lessThanOrEqualTo(contentView)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(6)
            make.bottom.equalTo(dayLabel).offset(6)
        }
    }
    
    func setDate(_ date: Date) {
        self.date = date
        self.dayOfWeekLabel.text = date.formatted(Date.FormatStyle()
            .locale(.init(identifier: "en-US"))
            .weekday(.abbreviated))
        if let day = self.calendar?.gregorian.component(.day, from: date) {
            self.dayLabel.text = "\(day)"
        }
    }
    
    override func layoutSubviews() {
        UIView.transition(with: contentView,
                          duration: 0.2,
                          options: .transitionCrossDissolve) { [weak self] in
            guard let self = self else { return }
            if self.isSelected {
                self.selectedConfigure()
                print("celllll \(date)")
            } else {
                self.deselectedConfigure()
            }
        }
    }
    
    
    func selectedConfigure() {
        contentView.backgroundColor = .briefingWhite
        dayOfWeekLabel.textColor = .briefingNavy
        dayLabel.textColor = .briefingNavy
    }
    
    func deselectedConfigure() {
        contentView.backgroundColor = .clear
        dayOfWeekLabel.textColor = .briefingWhite
        dayLabel.textColor = .briefingWhite
    }
}
