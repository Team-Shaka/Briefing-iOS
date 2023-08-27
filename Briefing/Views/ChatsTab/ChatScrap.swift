//
//  ChatScrap.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import UIKit
import WebKit

class ChatScrap: UIViewController {
    let layout_nav = UIView()
    let layout_web = UIView()
    
    var webChatScrapView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainGray
        
        navigationController?.isNavigationBarHidden = true
        
        setNav()
        setChatScrapWebView()
    }
    
    private func setUpWebView() {
        self.webChatScrapView = WKWebView()
        
        if let url = URL(string: "https://briefing-web.vercel.app/storage") {
            let request = URLRequest(url: url)
            webChatScrapView.load(request)
        }
    }
    
    private func setNav() {
        let label_title = UILabel()
        let button_back = UIButton()
        
        self.view.addSubview(layout_nav)
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(self.view.frame.height * 0.159)
            make.height.equalTo(100)
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
    
    private func setChatScrapWebView() {
        setUpWebView()
        
        self.view.addSubview(layout_web)
        
        layout_web.snp.makeConstraints{ make in
            make.top.equalTo(layout_nav.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        layout_web.addSubview(webChatScrapView)
        
        webChatScrapView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

}

extension ChatScrap {
    @objc func backButtonTapped() {
        print("chatscrap -> home")
        self.navigationController?.popViewController(animated: true)
    }
}
