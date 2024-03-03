//
//  DefaultScrapUseCase.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation
import RxSwift

final class DefaultScrapUseCase {
    private let authRepository: AuthRepository
    private let scrapRepository: ScrapRepository
    
    init(authRepository: AuthRepository, 
         scrapRepository: ScrapRepository) {
        self.authRepository = authRepository
        self.scrapRepository = scrapRepository
    }
}

extension DefaultScrapUseCase: ScrapUseCase {
    func fetchScrapBriefings() -> Single<[(Date, [ScrapData])]> {
        scrapRepository.fetchScrapBriefings()
            .catch { error in
                self.authRepository.refreshToken()
                    .flatMap { _ in
                        self.scrapRepository.fetchScrapBriefings()
                    }
            }
    }
    
    func scrapBriefing(id: Int) -> Single<ScrapResult> {
        scrapRepository.scrapBriefing(id: id)
            .catch { error in
                self.authRepository.refreshToken()
                    .flatMap { _ in
                        self.scrapRepository.scrapBriefing(id: id)
                    }
            }
    }
    
    func deleteScrapBriefing(id: Int) -> Single<ScrapResult> {
        scrapRepository.deleteScrapBriefing(id: id)
            .catch { error in
                self.authRepository.refreshToken()
                    .flatMap { _ in
                        self.scrapRepository.deleteScrapBriefing(id: id)
                    }
            }
    }
}
