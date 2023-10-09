//
//  SettingTableViewTimePickerCell.swift
//  Briefing
//
//  Created by 이전희 on 10/9/23.
//

import UIKit

protocol SettingTableViewTimePickerCellDelegate {
    func changeTimePickerValue()
    func isAvailableTimePicker() -> Bool
}



class SettingTableViewTimePickerCell: UITableViewCell, SettingTableViewCell {
    static let identifier: String = String(describing: SettingTableViewTimePickerCell.self)
    private var delegate: SettingTableViewTimePickerCellDelegate? = nil
    private var isUrlType: Bool = false
    
    private var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .briefingNavy
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18)
        label.textColor = .briefingNavy
        return label
    }()
    
    private var timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.tintColor = .briefingNavy
        // datePicker.backgroundColor = .briefingLightBlue
        datePicker.timeZone = .current
        
        return datePicker
    }()
    
    private var nextIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BriefingImageCollection.nextIconImage
        imageView.tintColor = .briefingNavy
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func prepareForReuse() {
        timePicker.isEnabled = delegate?.isAvailableTimePicker() ?? false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        self.layoutMargins = UIEdgeInsets.zero
        self.timePicker.addTarget(self, action: #selector(timePickerValueChanged(_:)), for: .valueChanged)
    }
    
    func addSubviews() {
        self.contentView.addSubview(mainContainerView)
        
        let subViews: [UIView] = [symbolImageView, titleLabel]
        subViews.forEach { subView in
            mainContainerView.addSubview(subView)
        }
    }
    
    func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        symbolImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(symbolImageView.snp.trailing).offset(12)
        }
    }
    
    func setCellData(symbol: UIImage,
                     title: String,
                     delegate: SettingTableViewTimePickerCellDelegate,
                     cornerMaskEdge: UIRectEdge?) {
        symbolImageView.image = symbol
        titleLabel.text = title
        self.delegate = delegate
        cellLayoutSetting()
        mainContainerView.setCornerMask(cornerMaskEdge)
    }
    
    func cellLayoutSetting(){
        if isUrlType {
            mainContainerView.addSubview(nextIconImageView)
            titleLabel.snp.makeConstraints { make in
                make.trailing.lessThanOrEqualTo(nextIconImageView.snp.leading)
            }
            
            nextIconImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(18)
                make.width.height.equalTo(20)
            }
        } else {
            mainContainerView.addSubview(timePicker)
            nextIconImageView.isHidden = true
            titleLabel.snp.makeConstraints { make in
                make.trailing.lessThanOrEqualTo(timePicker.snp.leading)
            }
            
            timePicker.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(18)
            }
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.backgroundColor = .clear
        guard isUrlType else { return }
        if highlighted {
            mainContainerView.backgroundColor = .briefingLightBlue.withAlphaComponent(0.3)
        } else {
            mainContainerView.backgroundColor = .white
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.backgroundColor = .clear
    }
    
    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
        print(sender.date)
    }
}
