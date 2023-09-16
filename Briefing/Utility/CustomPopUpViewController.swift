//
//  CustomPopUpViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/16.
//

import UIKit

class CustomPopUpViewController: UIViewController {
    var style: CustomPopUpViewController.Style
    
    private var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonGray
        return button
    }()
    
    private var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondBlue
        return button
    }()
    
    
    init(title: String,
         description: String,
         buttonTitles: [String],
         style: Style=Style()) {
//        self.url = url
//        self.metadata = metadata
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configure()
        addSubviews()
        makeConstraint()
    }
    
    private func configure() {
        self.view.backgroundColor = .dimGray
        
    }
    
    private func addSubviews() {
        self.view.addSubviews(<#T##views: UIView...##UIView#>)
    }
    
    private func makeConstraint() {
        mainContainer.snp.makeConstraints{ make in
            
        }
        
        cancelButton.snp.makeConstraints{ make in
            
        }
        
        confirmButton.snp.makeConstraints{ make in
            
        }
    }
    
}

