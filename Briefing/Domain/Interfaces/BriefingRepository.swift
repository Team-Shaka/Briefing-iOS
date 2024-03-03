//
//  BriefingRepository.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation
import RxSwift

protocol BriefingRepository {
    func fetchKeywords(date: Date?,
                       type: KeywordsType) -> Single<Keywords>
    func fetchBriefingCard(id: Int) -> Single<BriefingData>
}
