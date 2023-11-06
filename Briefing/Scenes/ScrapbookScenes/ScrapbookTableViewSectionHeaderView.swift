//
//  ScrapbookTableViewSectionHeaderView.swift
//  Briefing
//
//  Created by BoMin Lee on 11/5/23.
//

import UIKit

class ScrapbookTableViewSectionHeaderView: UIView {
    static let identifier: String = String(describing: ScrapbookTableViewSectionHeaderView.self)
    
    private var mainView: UIView = {
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

    init(Date: Date) {
        super.init(frame: .zero)
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
        mainView.addSubviews(dateLabel)
        self.addSubviews(mainView)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(41)
            make.centerY.equalToSuperview()
        }
    }

}
