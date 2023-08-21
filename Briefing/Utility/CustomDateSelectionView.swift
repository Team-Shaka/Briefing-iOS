//
//  CustomDateSelectionView.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class DateSelectionView: UIView {
    
    private var dateLabels: [UILabel] = []
    private var selectedDateIndex: Int = 0 {
        didSet {
            updateDateColors()
        }
    }
    
    private let scrollView = UIScrollView()
    var dates: [String] {
        didSet {
            configureDates()
        }
    }
    
    init(dates: [String]) {
        self.dates = dates
        self.selectedDateIndex = dates.count - 1  // 마지막 인덱스로 설정
        super.init(frame: .zero)
        
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        configureDates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDates() {
        // 기존 레이블 제거
        dateLabels.forEach { $0.removeFromSuperview() }
        dateLabels.removeAll()
        
        for (index, date) in dates.enumerated() {
            let label = UILabel()
            label.text = date
            label.textAlignment = .center
            label.font = UIFont(name: "ProductSans-Regular", size: 15)
            label.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateTapped))
            label.addGestureRecognizer(tapGesture)
            label.tag = index
            
            dateLabels.append(label)
            scrollView.addSubview(label)
        }
        
        updateDateColors()
        
        // 중앙 위치 설정 코드를 디스패치 대기열에 넣기
        DispatchQueue.main.async { [weak self] in
            self?.setInitialPosition()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        let labelWidth: CGFloat = 80.0
        for (index, label) in dateLabels.enumerated() {
            label.frame = CGRect(x: CGFloat(index) * labelWidth, y: 0, width: labelWidth, height: frame.height)
        }
        
        scrollView.contentSize = CGSize(width: labelWidth * CGFloat(dates.count), height: frame.height)
    }
    
    @objc private func dateTapped(sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel, label.tag != selectedDateIndex {
            selectedDateIndex = label.tag

            // 선택된 레이블이 중앙에 오도록 조정
            let targetOffsetX = label.center.x - scrollView.bounds.width / 2
            scrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)

            // 필요한 경우, 선택된 날짜에 대한 추가 작업을 여기에 추가합니다.
        }
    }
    
    private func updateDateColors() {
        for (index, label) in dateLabels.enumerated() {
            if index == selectedDateIndex {
                label.textColor = .white
                
                // 선택된 레이블이 중앙에 오도록 조정
                let targetOffsetX = label.center.x - scrollView.bounds.width / 2
                scrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
            } else {
                label.textColor = .thirdBlue
            }
        }
    }
    
    private func setInitialPosition() {
        if selectedDateIndex >= 0 && selectedDateIndex < dateLabels.count {
            let selectedLabel = dateLabels[selectedDateIndex]
            let targetOffsetX = selectedLabel.frame.origin.x - (scrollView.bounds.width / 2) + (selectedLabel.frame.width / 2)
            let adjustedOffsetX = max(0, min(targetOffsetX, scrollView.contentSize.width - scrollView.bounds.width))
            scrollView.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: false)
        }
    }
}
