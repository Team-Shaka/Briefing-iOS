//
//  SettingTableViewHeaderView.swift
//  Briefing
//
//  Created by 이전희 on 11/7/23.
//

import UIKit

final class SettingTableViewSectionHeaderView: UIView {
    var title: String
    
    private var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 18)
        label.textColor = .black
        return label
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.titleLabel.text = title
    }
    
    private func addSubviews() {
        addSubviews(mainView)
        mainView.addSubviews(titleLabel)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
}
