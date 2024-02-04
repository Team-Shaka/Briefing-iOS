//
//  NetworkManager.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/23.
//

import Foundation
import Alamofire
import RxSwift

final class BriefingNetworkManager: BFNetworkManager {
    static let shared: BriefingNetworkManager = BriefingNetworkManager()
    private init() { }
    
    @UserDefaultWrapper(key: .member, defaultValue: nil)
    var member: Member?
}

// MARK: - rx functions for Briefing
extension BriefingNetworkManager {
    func fetchKeywords(date: Date? = nil,
                       type: BriefingNetworkURLRequest.KeywordsType) -> Single<Keywords> {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let urlRequest = BriefingNetworkURLRequest(/*member?.accessToken,*/
                                                         url: url,
                                                         method: .get,
                                                         path: .keywords,
                                                         query: [.type: type.rawValue]) else {
            return Single.error(BFNetworkError.wrongURLRequestError)
        }
        return response(urlRequest,
                        type: Keywords.self)
    }
    
    func fetchBriefingCard(id: Int) -> Single<BriefingData> {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let urlRequest = BriefingNetworkURLRequest(/*member?.accessToken,*/
                                                         url: url,
                                                         method: .get,
                                                         path: .briefingCard(id: id)) else {
            return Single.error(BFNetworkError.wrongURLRequestError)
        }
        
        return response(urlRequest,
                        type: BriefingData.self)
    }
}

// MARK: - rx functions for Scrap
extension BriefingNetworkManager {
    func fetchScrapBrifings() -> Single<[(Date, [ScrapData])]> {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let memberId = BriefingAuthManager.shared.member?.memberId else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .get,
                                                         path: .fetchScrap(memberId: memberId)) else {
            return Single.error(BFNetworkError.wrongURLRequestError)
        }
        
        return response(urlRequest,
                        type: [ScrapData].self)
        .map { scrapDatas in
            scrapDatas.reduce(Dictionary<Date,[ScrapData]>(), { partialResult, scrapData in
                var partialResult = partialResult
                let date = scrapData.date.toDate(dataFormat:"yyyy-MM-dd") ?? Date()
                partialResult[date, default: []].append(scrapData)
                return partialResult
            })
            .map { return ($0, $1) }
            .sorted(by: { $0.0 > $1.0 })
        }
    }
    
    func scrapBriefing(id: Int) -> Single<ScrapResult> {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let memberId = BriefingAuthManager.shared.member?.memberId else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .post,
                                                         path: .scrap,
                                                         httpBody: [.memberId: memberId,
                                                                    .briefingId: id]) else {
            return Single.error(BFNetworkError.wrongURLRequestError)
        }
        
        return response(urlRequest,
                        type: CreateScrapResult.self)
        .map { $0 as ScrapResult }
    }
    
    func deleteScrapBriefing(id: Int) -> Single<ScrapResult> {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let memberId = BriefingAuthManager.shared.member?.memberId else {
            return Single.error(BriefingNetworkError.noAuthError)
        }
        
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .delete,
                                                         path: .deleteScrap(id: id, memberId: memberId)) else {
            return Single.error(BFNetworkError.wrongURLRequestError)
        }
        
        return response(urlRequest,
                        type: DeleteScrapResult.self)
        .map { $0 as ScrapResult }
    }
}





// MARK: - ##### Legacy Code
// MARK: - (Legacy Code) functions for Briefing
extension BriefingNetworkManager {
    func fetchKeywords(date: Date,
                       type: BriefingNetworkURLRequest.KeywordsType,
                       completion: @escaping (_ value: Keywords?, _ error: Error?) -> Void) {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .get,
                                                         path: .keywords,
                                                         query: [.date: date.dateToString(),
                                                                 .type: type.rawValue]) else {
            completion(nil, BFNetworkError.wrongURLRequestError)
            return
        }
        
        response(urlRequest,
                 type: Keywords.self,
                 completion: completion)
    }
    
    func fetchBriefingCard(id: Int,
                           completion: @escaping (_ value: BriefingData?, _ error: Error?) -> Void) {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .get,
                                                         path: .briefingCard(id: id)) else {
            completion(nil, BFNetworkError.wrongURLRequestError)
            return
        }
        
        response(urlRequest,
                 type: BriefingData.self,
                 completion: completion)
    }
}

// MARK: - (Legacy Code) functions for Scrap
extension BriefingNetworkManager {
    
    func fetchScrapBrifings(completion: @escaping (_ value: [(Date, [ScrapData])]?, _ error: Error?) -> Void) {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let memberId = BriefingAuthManager.shared.member?.memberId else {
            completion(nil, BriefingNetworkError.noAuthError)
            return
        }
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .get,
                                                         path: .fetchScrap(memberId: memberId)) else {
            completion(nil, BFNetworkError.wrongURLRequestError)
            return
        }
        
        response(urlRequest,
                 type: [ScrapData].self,
                 completion: { value, error in
            let value = value?.reduce(Dictionary<Date,[ScrapData]>(), { partialResult, scrapData in
                var partialResult = partialResult
                let date = scrapData.date.toDate(dataFormat:"yyyy-MM-dd") ?? Date()
                partialResult[date, default: []].append(scrapData)
                return partialResult
            })
                .map { return ($0, $1) }
                .sorted(by: { $0.0 > $1.0 })
            completion(value, error)
        })
    }
    
    func scrapBriefing(id: Int,
                       completion: @escaping (_ value: (any ScrapResult)?, _ error: Error?) -> Void) {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let memberId = BriefingAuthManager.shared.member?.memberId else {
            completion(nil, BriefingNetworkError.noAuthError)
            return
        }
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .post,
                                                         path: .scrap,
                                                         httpBody: [.memberId: memberId,
                                                                    .briefingId: id]) else {
            completion(nil, BFNetworkError.wrongURLRequestError)
            return
        }
        
        response(urlRequest,
                 type: CreateScrapResult.self,
                 completion: completion)
    }
    
    func deleteScrapBriefing(id: Int,
                             completion: @escaping (_ value: (any ScrapResult)?, _ error: Error?) -> Void) {
        let url = BriefingURLContainer.url(key: .baseUrl)
        guard let memberId = BriefingAuthManager.shared.member?.memberId else {
            completion(nil, BriefingNetworkError.noAuthError)
            return
        }
        
        guard let urlRequest = BriefingNetworkURLRequest(member?.accessToken,
                                                         url: url,
                                                         method: .delete,
                                                         path: .deleteScrap(id: id, memberId: memberId)) else {
            completion(nil, BFNetworkError.wrongURLRequestError)
            return
        }
        
        response(urlRequest,
                 type: DeleteScrapResult.self,
                 completion: completion)
    }
}
