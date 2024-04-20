//
//  OutingStatusViewModel.swift
//  Feature
//
//  Created by 새미 on 4/19/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service
import Foundation

public final class OutingViewModel {
    private let outingProvider = MoyaProvider<OutingServices>()
    
    let keyChain = KeyChain()
    let gomsRefreshToken = GOMSRefreshToken.shared
    lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")
    
    var outingList: [OutingListResponse] = []
    
    private var authorization: String = ""

    func getOutingList() {
        outingProvider.request(.outingList(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                do {
                    let statusCode = result.statusCode
                    switch statusCode {
                    case 200:
                        print("OK")
                        print(result)
                        self.outingList = try JSONDecoder().decode([OutingListResponse].self, from: responseData)
                    case 401:
                        self.gomsRefreshToken.tokenReissuance()
                    case 404:
                        print("외출한 사람이 없을 경우")
                    case 500:
                        print("SERVER ERROR")
                    default:
                        print(result)
                    }
                } catch {
                    print("error")

                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func outingCount() {
        outingProvider.request(.outingCount(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("OK")
                case 401:
                    print("만료된 accessToken일 경우")
                    print("유효하지 않은 accessToken일 경우")
                    self.gomsRefreshToken.tokenReissuance()
                case 500:
                    print("SERVER ERROR")
                default:
                    print(result)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
