//
//  BriefingTableViewCell.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import UIKit

class BriefingTableViewCell: UITableViewCell {
    static let cellID = "BrefingTableViewCell"
    
    weak var delegate: BriefingTableViewCellDelegate?
    
    let layout_main = UIView()
    
    let label_order = UILabel()
    let label_topic = UILabel()
    let label_descript = UILabel()
    let button_details = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .mainGray
        self.addSubview(layout_main)
        
        layout_main.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(13)
        }
        
        layout_main.backgroundColor = .white
        layout_main.layer.cornerRadius = self.frame.width * 0.11
        layout_main.addShadow(offset: CGSize(width: 0, height: 4),
                              color: .black,
                              radius: 5,
                              opacity: 0.1)
        
        layout_main.addSubviews(label_order, label_topic, label_descript, button_details)
        
        label_order.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.frame.width * 0.04)
            make.width.height.equalTo(self.frame.width * 0.125)
        }
        
        label_order.backgroundColor = .mainBlue
        label_order.textAlignment = .center
        label_order.textColor = .white
        label_order.font = UIFont(name: "ProductSans-Bold", size: 19)
        label_order.numberOfLines = 1
        label_order.layer.masksToBounds = true
        label_order.layer.cornerRadius = (self.frame.width * 0.125) / 2
        
        label_topic.snp.makeConstraints{ make in
            make.leading.equalTo(label_order.snp.trailing).offset(self.frame.width * 0.04)
            make.top.equalTo(label_order).offset(3)
        }
        
        label_topic.textAlignment = .left
        label_topic.textColor = .mainBlue
        label_topic.font = UIFont(name: "ProductSans-Bold", size: 17)
        label_topic.numberOfLines = 1
        
        label_descript.snp.makeConstraints{ make in
            make.leading.equalTo(label_topic)
            make.top.equalTo(label_topic.snp.bottom).offset(self.frame.height * 0.056)
            make.width.equalTo(self.frame.width * 0.51)
        }
        
        label_descript.textAlignment = .left
        label_descript.textColor = .thirdBlue
        label_descript.font = UIFont(name: "ProductSans-Bold", size: 10)
        label_descript.numberOfLines = 1
        
        button_details.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(self.frame.width * 0.04)
            make.width.height.equalTo(self.frame.width * 0.075)
        }
        
        button_details.setImage(UIImage(named: "details"), for: .normal)
        
        let layout_touch = UIView()
        
        self.addSubview(layout_touch)
        
        layout_touch.snp.makeConstraints{ make in
            make.top.leading.bottom.trailing.equalTo(layout_main)
        }
        
        layout_touch.backgroundColor = .systemPink
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(layoutMainTapped))
        tapGesture.delegate = self
        layout_touch.addGestureRecognizer(tapGesture)
        layout_touch.isUserInteractionEnabled = true
    }
    
    @objc private func layoutMainTapped() {
        print("ssibal")
        delegate?.didTapLayoutMain(in: self)
    }
    
    func configureOrderLabel(forIndex index: Int) {
        switch index {
        case 0:
            label_order.backgroundColor = .mainBlue
            label_order.textColor = .white
        case 1:
            label_order.backgroundColor = .secondBlue
            label_order.textColor = .white
        case 2:
            label_order.backgroundColor = .thirdBlue
            label_order.textColor = .white
        default:
            label_order.backgroundColor = .clear
            label_order.textColor = .mainBlue
        }
    }

}

protocol BriefingTableViewCellDelegate: AnyObject {
    func didTapLayoutMain(in cell: BriefingTableViewCell)
}

