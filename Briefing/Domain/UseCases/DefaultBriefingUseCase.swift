//
//  BriefingUseCase.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation
import RxSwift

final class DefaultBriefingUseCase {
    private let briefingRepository: BriefingRepository
    
    init(briefingRepository: BriefingRepository) {
        self.briefingRepository = briefingRepository
    }
}

extension DefaultBriefingUseCase: BriefingUseCase {
    func fetchKeywords(date: Date? = nil,
                       type: KeywordsType) -> Single<Keywords> {
        briefingRepository.fetchKeywords(date: date, type: type)
    }
    
    func fetchBriefingCard(id: Int) -> Single<BriefingData> {
        briefingRepository.fetchBriefingCard(id: id)
    }
}
