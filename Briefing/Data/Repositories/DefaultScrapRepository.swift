//
//  DefaultScrapRepository.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation
import RxSwift

final class DefaultScrapRepository: BFNetworkService {
    private let baseUrl = BriefingURLContainer.url(key: .baseUrl)
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    private var member: Member?
}

extension DefaultScrapRepository: ScrapRepository {
    func fetchScrapBriefings() -> Single<[(Date, [ScrapData])]> {
        guard let member = member else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        
        let endpoint = ScrapEndpoints.fetchScrap(accessToken: member.accessToken,
                                                       url: baseUrl,
                                                       memberId: member.memberId)
        
        return response(endpoint,
                        type: [ScrapDataDTO].self)
        .map { scrapDatas in
            scrapDatas.reduce(Dictionary<Date,[ScrapData]>(), { partialResult, scrapData in
                var partialResult = partialResult
                let date = scrapData.date.toDate(dataFormat:"yyyy-MM-dd") ?? Date()
                partialResult[date, default: []].append(scrapData.toDomain())
                return partialResult
            })
            .map { return ($0, $1) }
            .sorted(by: { $0.0 > $1.0 })
        }
    }
    
    func scrapBriefing(id: Int) -> Single<ScrapResult> {
        guard let member = member else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        
        let endpoint = ScrapEndpoints.scrap(accessToken: member.accessToken,
                                                  url: baseUrl,
                                                  memberId: member.memberId,
                                                  briefingId: id)
        
        return response(endpoint,
                        type: CreateScrapResultDTO.self)
        .map { $0.toDomain() }
    }
    
    func deleteScrapBriefing(id: Int) -> Single<ScrapResult> {
        guard let member = member else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        
        let endpoint = ScrapEndpoints.deleteScrap(accessToken: member.accessToken,
                                                        url: baseUrl,
                                                        memberId: member.memberId,
                                                        briefingId: id)
        
        return response(endpoint,
                        type: DeleteScrapResultDTO.self)
        .map { $0.toDomain() }
    }
}
