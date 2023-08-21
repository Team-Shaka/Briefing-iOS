//
//  ChatScrap.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import UIKit

class ChatScrap: UIViewController {
    let layout_nav = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainGray
        
        navigationController?.isNavigationBarHidden = true
        
        setNav()
        setBottom()
    }
    
    private func setNav() {
        let label_title = UILabel()
        let button_back = UIButton()
        
        self.view.addSubview(layout_nav)
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.159)
        }
        
        layout_nav.addSubviews(label_title, button_back)
        
        label_title.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(15)
        }
        
        label_title.text = "채팅 기록"
        label_title.textColor = .mainBlue
        label_title.font = UIFont(name: "ProductSans-Regular", size: 24)
        label_title.textAlignment = .center
        label_title.numberOfLines = 1
        
        button_back.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.leading.equalToSuperview().offset(self.view.frame.width * 0.076)
            make.width.height.equalTo(25)
        }
        
        button_back.setImage(UIImage(named: "arrow_blue"), for: .normal)
        button_back.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setBottom() {
        let layout_bottom = UIView()
        
        self.view.addSubview(layout_bottom)
        
        layout_bottom.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.123)
        }
        
        layout_bottom.backgroundColor = .mainGray
    }
}

extension ChatScrap {
    @objc func backButtonTapped() {
        print("chatscrap -> home")
        self.navigationController?.popViewController(animated: true)
    }
}
