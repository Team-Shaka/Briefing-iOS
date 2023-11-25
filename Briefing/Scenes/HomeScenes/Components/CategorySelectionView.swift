//
//  CategorySelectionView.swift
//  Briefing
//
//  Created by 이전희 on 11/25/23.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class CategorySelectionView: UIView {    
    let categories: [BriefingCategory]
    let selectedCategoryRelay: BehaviorRelay<Int>
    let disposeBag = DisposeBag()
    
    var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 22
        return stackView
    }()
    
    lazy var categoryButtons: [UIButton] = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: 2, leading: 6, bottom: 2, trailing: 6)
        return categories.enumerated().map { idx, category in
            let button = UIButton(configuration: configuration)
            button.setTitle(category.localized, for: .normal)
            button.setTitleColor(.bfTextBlack, for: .normal)
            button.titleLabel?.font = .productSans(size: 18)
            button.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
            button.tag = idx
            return button
        }
    }()
    
    lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = .bfPrimaryBlue
        return view
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .bfSeperatorGray
        return view
    }()
    
    init(categories: [BriefingCategory],
         selectedCategoryRelay: BehaviorRelay<Int>) {
        self.categories = categories
        self.selectedCategoryRelay = selectedCategoryRelay
        super.init(frame: .zero)
        configure()
        addSubviews()
        makeConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
    
    private func addSubviews() {
        categoryButtons.forEach { button in
            categoryStackView.addArrangedSubview(button)
        }
        
        let mainSubviews: [UIView] = [categoryStackView, divider, underline]
        
        mainSubviews.forEach { subview in
            self.addSubview(subview)
        }
    }
    
    private func makeConstraints() {
        categoryStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(22)
            make.trailing.lessThanOrEqualToSuperview().inset(22).priority(.low)
            make.top.equalToSuperview()
            make.bottom.equalTo(divider.snp.top).offset(-4)
        }
        
        divider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1.5)
            make.bottom.equalToSuperview()
        }
        
        self.underline.snp.makeConstraints { make in
            make.height.centerY.equalTo(self.divider)
            make.leading.trailing.equalTo(self.categoryButtons[0])
        }
    }
    
    private func bind() {
        selectedCategoryRelay.subscribe { [weak self] category in
            guard let self = self else { return }
            let index = self.selectedCategoryRelay.value
            UIView.animate(withDuration: 0.25) {
                self.underline.snp.removeConstraints()
                self.underline.snp.makeConstraints { make in
                    make.height.centerY.equalTo(self.divider)
                    make.leading.trailing.equalTo(self.categoryButtons[index])
                }
                self.layoutIfNeeded()
            }
        }
        .disposed(by: disposeBag)
    }
    
    @objc
    func selectCategory(sender: UIButton) {
        self.selectedCategoryRelay.accept(sender.tag)
    }
}
