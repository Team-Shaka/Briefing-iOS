//
//  CustomDateSelectionView.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class CustomDateSelectionView: UIView {
    weak var delegate: CustomDateSelectionViewDelegate?
    
    private var isInitialPositionSet = false
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
        self.selectedDateIndex = dates.count - 3  // 마지막 인덱스로 설정
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
            
            if date.isEmpty {
                label.isUserInteractionEnabled = false
            } else {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateTapped))
                label.addGestureRecognizer(tapGesture)
            }
            
            label.tag = index
            
            dateLabels.append(label)
            scrollView.addSubview(label)
        }
        
        updateDateColors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        let labelWidth: CGFloat = 80.0
        for (index, label) in dateLabels.enumerated() {
            label.frame = CGRect(x: CGFloat(index) * labelWidth, y: 0, width: labelWidth, height: frame.height - 15)
        }
        
        scrollView.contentSize = CGSize(width: labelWidth * CGFloat(dates.count), height: frame.height)
        
        if !isInitialPositionSet {
            setInitialPosition()
            isInitialPositionSet = true
        }
        
        
    }
    
    @objc private func dateTapped(sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel, label.tag != selectedDateIndex {
            selectedDateIndex = label.tag

            // 선택된 레이블이 중앙에 오도록 조정
            let targetOffsetX = label.center.x - scrollView.bounds.width / 2
            scrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)

            delegate?.dateSelectionView(self, didSelectDateAtIndex: label.tag)
        }
    }
    
    private func updateDateColors() {
        for (index, label) in dateLabels.enumerated() {
            if index == selectedDateIndex {
                label.textColor = .white
                label.layer.addBorder([.bottom], color: .white, width: 2.0)
                
                // 선택된 레이블이 중앙에 오도록 조정
                let targetOffsetX = label.center.x - scrollView.bounds.width / 2
                scrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
            } else {
                label.textColor = .thirdBlue
                label.layer.addBorder([.bottom], color: .secondBlue, width: 2.0)
            }
        }
    }
    
    private func setInitialPosition() {
        let selectedLabel = dateLabels[selectedDateIndex]
        let targetOffsetX = selectedLabel.frame.origin.x - (scrollView.bounds.width / 2) + (selectedLabel.frame.width / 2)
        let adjustedOffsetX = max(0, min(targetOffsetX, scrollView.contentSize.width - scrollView.bounds.width))
        scrollView.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: false)
        selectedLabel.layer.addBorder([.bottom], color: .white, width: 2.0)
    }
}

protocol CustomDateSelectionViewDelegate: AnyObject {
    func dateSelectionView(_ view: CustomDateSelectionView, didSelectDateAtIndex index: Int)
}


