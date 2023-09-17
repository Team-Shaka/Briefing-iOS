//
//  BriefingToggleButton.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

//import UIKit
//
//class BriefingToggleButton: UIControl {
//
//    var delegate: BriefingToggleButtonDelegate?
//
//    var isOn: Bool = false {
//        didSet {
//            animateToggle()
//            sendActions(for: .valueChanged)
//            self.delegate?.didToggle(isOn: self.isOn)
//        }
//    }
//
//    private let onLabel: UILabel
//    private let offLabel: UILabel
//    private let slider: UIView
//    private let sliderLabel: UILabel
//
//    init(onTitle: String, offTitle: String) {
//        onLabel = UILabel()
//        offLabel = UILabel()
//        slider = UIView()
//        sliderLabel = UILabel()
//
//        super.init(frame: .zero)
//
//        onLabel.text = onTitle
//        offLabel.text = offTitle
//        onLabel.font = UIFont(name: "ProductSans-Bold", size: 11)
//        offLabel.font = UIFont(name: "ProductSans-Bold", size: 11)
//        sliderLabel.text = isOn ? offTitle : onTitle
//
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupViews() {
//        onLabel.textAlignment = .center
//        offLabel.textAlignment = .center
//        sliderLabel.textAlignment = .center
//
//        slider.backgroundColor = .mainBlue
//        slider.layer.cornerRadius = 12
//        sliderLabel.textColor = .white
//        sliderLabel.font = UIFont(name: "ProductSans-Bold", size: 11)
////        backgroundColor = .white
//
//        addSubview(onLabel)
//        addSubview(offLabel)
//        slider.addSubview(sliderLabel)  // Slider 내에 레이블 추가
//        addSubview(slider)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleTapped))
//        addGestureRecognizer(tapGesture)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let labelWidth = frame.width / 2
//        onLabel.frame = CGRect(x: 0, y: 0, width: labelWidth, height: frame.height)
//        offLabel.frame = CGRect(x: labelWidth, y: 0, width: labelWidth, height: frame.height)
//        onLabel.textColor = isOn ? .thirdBlue : .white
//        offLabel.textColor = isOn ? .white : .thirdBlue
//
//        let sliderWidth = labelWidth - 7
//        let sliderHeight = frame.height - 11
//        let sliderSize = CGSize(width: sliderWidth, height: sliderHeight)
//        let centerY = (frame.height - sliderHeight) / 2
//        if isOn {
//            slider.frame = CGRect(origin: CGPoint(x: labelWidth + 3.5, y: centerY), size: sliderSize)
//        } else {
//            slider.frame = CGRect(origin: CGPoint(x: 3.5, y: centerY), size: sliderSize)
//        }
//
//        sliderLabel.frame = CGRect(x: 0, y: 0, width: sliderWidth, height: sliderHeight)
//    }
//
//    @objc private func toggleTapped() {
//        isOn.toggle()
//        sliderLabel.text = isOn ? offLabel.text : onLabel.text
//    }
//
//    private func animateToggle() {
//        UIView.animate(withDuration: 0.3) {
//            self.layoutSubviews()
//        }
//    }
//}
//
//protocol BriefingToggleButtonDelegate: AnyObject {
//    func didToggle(isOn: Bool)
//}

import UIKit

class BriefingToggleButton: UIControl {
    
    var delegate: BriefingToggleButtonDelegate?
    
    var isOn: Bool = false {
        didSet {
            //animateToggle()  // Commented out to disable animation
            sendActions(for: .valueChanged)
            self.delegate?.didToggle(isOn: self.isOn)
        }
    }
    
    private let onLabel: UILabel
    private let offLabel: UILabel
    private let slider: UIView
    private let sliderLabel: UILabel
    
    init(onTitle: String, offTitle: String) {
        onLabel = UILabel()
        offLabel = UILabel()
        slider = UIView()
        sliderLabel = UILabel()
        
        super.init(frame: .zero)
        
        onLabel.text = onTitle
        offLabel.text = offTitle
        onLabel.font = UIFont(name: "ProductSans-Bold", size: 11)
        offLabel.font = UIFont(name: "ProductSans-Bold", size: 11)
//        sliderLabel.text = isOn ? offTitle : onTitle
        sliderLabel.text = onTitle
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        onLabel.textAlignment = .center
        offLabel.textAlignment = .center
        sliderLabel.textAlignment = .center
        
        slider.backgroundColor = .mainBlue
        slider.layer.cornerRadius = 12
        sliderLabel.textColor = .white
        sliderLabel.font = UIFont(name: "ProductSans-Bold", size: 11)
        // backgroundColor = .white
        
        addSubview(onLabel)
        addSubview(offLabel)
        slider.addSubview(sliderLabel)  // Slider 내에 레이블 추가
        addSubview(slider)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleTapped))
        addGestureRecognizer(tapGesture)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let labelWidth = frame.width / 2
//        onLabel.frame = CGRect(x: 0, y: 0, width: labelWidth, height: frame.height)
//        offLabel.frame = CGRect(x: labelWidth, y: 0, width: labelWidth, height: frame.height)
//
//        // Comment out these lines to prevent the color from changing
//        // onLabel.textColor = isOn ? .thirdBlue : .white
//        // offLabel.textColor = isOn ? .white : .thirdBlue
//
//        onLabel.textColor = .white
//        offLabel.textColor = .thirdBlue
//
//        let sliderWidth = labelWidth - 7
//        let sliderHeight = frame.height - 11
//        let sliderSize = CGSize(width: sliderWidth, height: sliderHeight)
//        let centerY = (frame.height - sliderHeight) / 2
//        if isOn {
//            slider.frame = CGRect(origin: CGPoint(x: labelWidth + 3.5, y: centerY), size: sliderSize)
//        } else {
//            slider.frame = CGRect(origin: CGPoint(x: 3.5, y: centerY), size: sliderSize)
//        }
//
//        sliderLabel.frame = CGRect(x: 0, y: 0, width: sliderWidth, height: sliderHeight)
//    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let labelWidth = frame.width / 2
        onLabel.frame = CGRect(x: 0, y: 0, width: labelWidth, height: frame.height)
        offLabel.frame = CGRect(x: labelWidth, y: 0, width: labelWidth, height: frame.height)
        
        // Set the text color here
        onLabel.textColor = .white
        offLabel.textColor = .thirdBlue

        let sliderWidth = labelWidth - 7
        let sliderHeight = frame.height - 11
        let sliderSize = CGSize(width: sliderWidth, height: sliderHeight)
        let centerY = (frame.height - sliderHeight) / 2
        
        sliderLabel.text = isOn ? offLabel.text : onLabel.text  // Set the text based on the current state

        if isOn {
            slider.frame = CGRect(origin: CGPoint(x: labelWidth + 3.5, y: centerY), size: sliderSize)
        } else {
            slider.frame = CGRect(origin: CGPoint(x: 3.5, y: centerY), size: sliderSize)
        }

        sliderLabel.frame = CGRect(x: 0, y: 0, width: sliderWidth, height: sliderHeight)
    }

    
    @objc private func toggleTapped() {
        isOn.toggle()
//        sliderLabel.text = isOn ? offLabel.text : onLabel.text
    }
    
    // Commented out to disable animation
    // private func animateToggle() {
    //     UIView.animate(withDuration: 0.3) {
    //         self.layoutSubviews()
    //     }
    // }
}

protocol BriefingToggleButtonDelegate: AnyObject {
    func didToggle(isOn: Bool)
}

