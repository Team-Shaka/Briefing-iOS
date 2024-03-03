//
//  AppDIContainer.swift
//  Briefing
//
//  Created by 이전희 on 3/3/24.
//

import Foundation

// MARK: TEMP DI Container
final class AppDIContainer {
    static let shared: AppDIContainer = AppDIContainer()
    private init() { }
    
    // MARK: - Repository
    lazy var briefingRepository: BriefingRepository = DefaultBriefingRepository()
    lazy var authRepository: AuthRepository = DefaultAuthRepository()
    lazy var scrapRepository: ScrapRepository = DefaultScrapRepository()
    
    // MARK: - UseCase
    lazy var briefingUseCase: BriefingUseCase = DefaultBriefingUseCase(briefingRepository: briefingRepository)
    lazy var authUseCase: AuthUseCase = DefaultAuthUseCase(authRepository: authRepository)
    lazy var scrapUseCase: ScrapUseCase = DefaultScrapUseCase(authRepository: authRepository,
                                                              scrapRepository: scrapRepository)
}
