//
//  NetworkManager.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation
import Alamofire
import RxSwift

final class DefaultBriefingRepository: BFNetworkService {
    private let baseUrl = BriefingURLContainer.url(key: .baseUrl)
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    private var member: Member?
}

extension DefaultBriefingRepository: BriefingRepository {
    func fetchKeywords(date: Date? = nil,
                       type: KeywordsType) -> Single<Keywords> {
        let endpoint = BriefingEndpoints.keyword(url: baseUrl,
                                                         type: type)
                
        return response(endpoint,
                        type: KeywordsDTO.self)
        .map { $0.toDomain() }
    }
    
    func fetchBriefingCard(id: Int) -> Single<BriefingData> {
        let endpoint = BriefingEndpoints.briefingCard(url: baseUrl,
                                                              id: id)
        
        return response(endpoint,
                        type: BriefingDataDTO.self)
        .map { $0.toDomain() }
    }
}
