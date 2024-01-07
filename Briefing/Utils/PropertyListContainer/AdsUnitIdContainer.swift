//
//  AdsUnitIdContainer.swift
//  Briefing
//
//  Created by 이전희 on 1/7/24.
//

import Foundation

enum AdsUnitIdKey: String {
    case banner = "iOS-Banner"
}

final class AdsUnitIdContainer {
    private init() { }
    
    /// AdsUnitId - return the ad unit id corresponding to the key
    /// - Parameter key: ad unit id key
    /// - Returns: ad unit id
    static func adsUnitId(key: AdsUnitIdKey) -> String {
        guard let fileUrl = Bundle.main.url(forResource: "AdUnitIds", withExtension: "plist") else { fatalError("DOSEN'T EXIST AdUnitIds FILE") }
        guard let adUnitIdDictionary = NSDictionary(contentsOf: fileUrl) else { fatalError("DOSEN'T EXIST AdUnitIds KEY") }
        guard let adUnitId = adUnitIdDictionary[key.rawValue] as? String else { fatalError("COULDN'T CONVERT TO STRING") }
        return adUnitId
    }
}
