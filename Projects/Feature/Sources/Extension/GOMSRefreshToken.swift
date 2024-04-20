//
//  GOMSRefreshToken.swift
//  Feature
//
//  Created by 새미 on 4/8/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service

public class GOMSRefreshToken {
    static let shared = GOMSRefreshToken()
    private let authProvider = MoyaProvider<AuthServices>()
    private let keychain = KeyChain()
    var statusCode: Int = 0
    var reissuanceData: SignInResponse?
    private lazy var refreshToken = "Bearer " + (keychain.read(key: Const.KeyChainKey.refreshToken) ?? "")

    // 토큰 재발급
    func tokenReissuance() {
        authProvider.request(.refreshToken(refreshToken: refreshToken)) { response in
            switch response {
            case .success(let result):
                self.statusCode = result.statusCode
                do {
                    self.reissuanceData = try result.map(SignInResponse.self)
                }catch(let err) {
                    print(String(describing: err))
                }
                switch self.statusCode {
                case 200..<300:
                    self.updateToken()
                    print("update token")
                case 400, 401, 404:
                    print("error")
                default:
                    print("error")
                }
            case .failure(let err):
                print(String(describing: err))
            }
        }
    }
    
    func updateToken() {
        guard let accessToken = reissuanceData?.accessToken,
              let refreshToken = reissuanceData?.refreshToken,
              let authority = reissuanceData?.authority else {
            print("Failed to update token: Missing token data")
            return
        }
    
        if !keychain.update(token: accessToken, key: Const.KeyChainKey.accessToken) {
            print("실패")
        }
        
        if !keychain.update(token: refreshToken, key: Const.KeyChainKey.refreshToken) {
            print("실패")
        }
        
        if !keychain.update(token: authority, key: Const.KeyChainKey.authority) {
            print("실패")
        }
    }
}
