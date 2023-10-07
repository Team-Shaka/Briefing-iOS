//
//  Dictionary+.swift
//  Briefing
//
//  Created by 이전희 on 10/7/23.
//

import Foundation

extension Dictionary {
    func dictMap<K, V>(_ transform: (_ key: Key,_ value: Value) -> (K, V)) -> [K: V] {
        return Dictionary<K, V>(uniqueKeysWithValues: self.map { transform($0, $1) })
    }
}
