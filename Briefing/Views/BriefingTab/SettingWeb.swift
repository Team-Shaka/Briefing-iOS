//
//  SettingWeb.swift
//  Briefing
//
//  Created by BoMin on 2023/08/22.
//

import UIKit
import SafariServices

extension Setting {
    func openURLInSafari(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func openURLInExternalSafari(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension Setting {
    @objc func openFeedback() {
        
    }
    
    @objc func openVersionNotes() {
        openURLInSafari("https://onve.notion.site/Briefing-8af692ff041c4fc6931b2fc897411e6d?pvs=4")
    }
    
    @objc func openUserPolicies() {
//        openURLInExternalSafari("https://sites.google.com/view/brieifinguse/%ED%99%88")
        openURLInSafari("https://sites.google.com/view/brieifinguse/%ED%99%88")
    }
    
    @objc func openPrivacyPolicies() {
        openURLInSafari("https://sites.google.com/view/briefing-private/%ED%99%88")
    }
    
    @objc func openWarnings() {
        
    }
}
