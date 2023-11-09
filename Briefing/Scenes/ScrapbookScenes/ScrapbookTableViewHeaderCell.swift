//
//  ScrapbookTableViewHeaderCell.swift
//  Briefing
//
//  Created by BoMin Lee on 11/9/23.
//

import Foundation
import UIKit

class ScrapbookTableViewHeaderCell: UITableViewCell {
    static let identifier: String = String(describing: ScrapbookTableViewHeaderCell.self)
    
    private var mainContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .productSans(size: 15)
        label.textColor = .briefingNavy
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .clear
    }
    
    private func addSubviews() {
        mainContainerView.addSubviews(dateLabel)
        self.addSubviews(mainContainerView)
    }
    
    private func makeConstraints() {
        mainContainerView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(41)
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
    func setCellData(date: String,
                     cornerMaskEdge: UIRectEdge?) {
        dateLabel.text = date
        
        mainContainerView.setCornerMask(cornerMaskEdge)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.backgroundColor = .clear
    }
}
