//
//  Network.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import Foundation
import Alamofire

class Network {
    let baseURL = "https://7ab7c6c1-9228-4cb2-b19c-774d9cd8b73d.mock.pstmn.io"
    
    // 키워드 전달 GET
    func getKeywords(date: String, type: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseURL + "/briefings?date=\(date)&type=\(type)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.judgeStatus(object: 0, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
    // 브리핑 카드 GET
    func getBriefingCard(id: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseURL + "/briefings/\(id)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.judgeStatus(object: 1, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
}

extension Network {
    private func judgeStatus(object: Int = 0, by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            // Keywords 용
            if (object == 0) {
                return isValidData_Keywords(data: data)
            }
            // BriefingCard 용
            else if (object == 1) {
                return isValidData_BriefingCard(data: data)
            }
            else {
                return .success(data)
            }
            
        case 400: return .badRequest // 요청이 잘못됨
        case 404: return .notFound // 찾을 수 없음
        case 500: return .serverErr // 서버 에러
            
        default: return .networkFail // 네트워크 에러
        }
    }
    
    private func isValidData_Keywords(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(KeywordsData.self, from: data) else {
            return .decodeFail }
    
        return .success(decodedData)
    }
    
    private func isValidData_BriefingCard(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(BriefingCardData.self, from: data) else {
            return .decodeFail }
    
        return .success(decodedData)
    }

}
