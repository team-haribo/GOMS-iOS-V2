//
//  GOMSRefreshToken.swift
//  Feature
//
//  Created by 새미 on 4/8/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service

class GOMSRefreshToken {
    private let authProvider = MoyaProvider<AuthServices>()
//    private var reissuanceData = SignInResponse()
//    private let keychain = Keychain()
//    private lazy var refreshToken = "Bearer " + (keychain.read(key: Const.KeychainKey.refreshToken) ?? "")
    // 토큰 재발급
//    func tokenReissuance() {
//        authProvider.request(.refreshToken(refreshToken: <#T##String#>)) { response in
//            switch response {
//            case .success(let result):
//                    let statusCode = result.statusCode
//                음
//                    switch statusCode {
//                    case 200:
//                        print("OK")
//                    case 400:
//                        print("토큰을 요청하지 않은 경우")
//                    case 401:
//                        print("만료된 refreshToken일 경우 / 유효하지 않은 refreshToken일 경우")
//                    case 404:
//                        print("존재하지 않은 사용자 일 경우")
//                    case 500:
//                        print("SERVER ERROR")
//                    default:
//                        print(result)
//                    }
//                
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
}
