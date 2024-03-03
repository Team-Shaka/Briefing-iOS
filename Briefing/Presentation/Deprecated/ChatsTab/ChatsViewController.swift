//
//  ChatsViewController.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import UIKit
import WebKit

class ChatsViewController: UIViewController, TabBarItemViewController {
    let tabBarIcon: UIImage = BriefingImageCollection.chatTabBarNormalIconImage
    let tabBarSelectedIcon: UIImage = BriefingImageCollection.chatTabBarSelectedIconImage

    let layout_nav = UIView()
    let layout_chat = UIView()
    let layout_bottom = UIView()
    
    var webChatView: WKWebView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = .secondBlue
//        self.view.setGradient(color1: .secondBlue, color2: .mainBlue)
        
        setNav()
        setBottom()
        setChat()
    }
    
    private func setUpWebView() {
        self.webChatView = WKWebView()
        
        if let url = URL(string: "https://briefing-web.vercel.app/briefChat") {
            let request = URLRequest(url: url)
            webChatView.load(request)
        }
    }
    
    private func setNav() {
        self.view.addSubview(layout_nav)
        
        let label_title = UILabel()
        let button_storage = UIButton()
        let button_setting = UIButton()
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.141)
        }
        
        layout_nav.addSubviews(label_title, button_storage, button_setting)
        
        label_title.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(self.view.frame.height * 0.02)
            make.leading.equalTo(self.view.frame.width * 0.076)
        }
        
        label_title.text = "Breifing"
        label_title.textColor = .white
        label_title.font = UIFont(name: "ProductSans-Regular", size: 24)
        label_title.textAlignment = .left
        label_title.numberOfLines = 1
        
        button_storage.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.trailing.equalToSuperview().inset(self.view.frame.width * 0.06)
            make.width.height.equalTo(25)
        }
        
        button_storage.setImage(UIImage(named: "storage"), for: .normal)
        button_storage.addTarget(self, action: #selector(chatscrapButtonTapped), for: .touchUpInside)
    }
    
    private func setChat() {
        setUpWebView()
        
        self.view.addSubview(layout_chat)
        
        layout_chat.snp.makeConstraints{ make in
            make.top.equalTo(layout_nav.snp.bottom)
            make.bottom.equalTo(layout_bottom.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        layout_chat.addSubview(webChatView)
        
        webChatView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setBottom() {
        self.view.addSubview(layout_bottom)
        
        layout_bottom.snp.makeConstraints{ make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.123)
        }
        
        layout_bottom.backgroundColor = .mainGray
    }
}

extension ChatsViewController {
    @objc func chatscrapButtonTapped() {
        print("chatscrap tapped")
        let nextVC = ChatScrap()
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
