//
//  ScrapRepository.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation
import RxSwift

protocol ScrapRepository {
    func fetchScrapBriefings() -> Single<[(Date, [ScrapData])]>
    func scrapBriefing(id: Int) -> Single<ScrapResult>
    func deleteScrapBriefing(id: Int) -> Single<ScrapResult>
}
