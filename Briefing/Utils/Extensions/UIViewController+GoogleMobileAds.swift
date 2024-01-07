//
//  UIViewController+GoogleMobileAds.swift
//  Briefing
//
//  Created by 이전희 on 1/7/24.
//

import UIKit
import GoogleMobileAds

extension UIViewController {
    func addBannerAdView() -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        let adUnitId = AdsUnitIdContainer.adsUnitId(key: .banner)
        bannerView.adUnitID = adUnitId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        return bannerView
    }
}
