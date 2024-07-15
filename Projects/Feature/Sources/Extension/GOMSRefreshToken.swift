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
    public static let shared = GOMSRefreshToken()
    private let authProvider = MoyaProvider<AuthServices>()
    private let keychain = KeyChain()
    var statusCode: Int = 0
    var reissuanceData: SignInResponse?
    private lazy var refreshToken = "Bearer " + (keychain.read(key: Const.KeyChainKey.refreshToken) ?? "")

    // 토큰 재발급
    public func tokenReissuance() {
        authProvider.request(.refreshToken(refreshToken: refreshToken)) { response in
            switch response {
            case .success(let result):
                self.statusCode = result.statusCode
                switch self.statusCode {
                case 200:
                    do {
                        self.reissuanceData = try result.map(SignInResponse.self)
                        self.updateKeychainToken()
                    } catch(let err) {
                        print(String(describing: err))
                    }
                    print("update token")
                case 400, 401, 404:
                    print("token error")
                default:
                    print("token error")
                }
            case .failure(let err):
                print(String(describing: err))
            }
        }
    }
    
    func updateKeychainToken() {
        let accessTokenUpdated = self.keychain.updateItem(
            token: self.reissuanceData?.accessToken ?? "",
            key: Const.KeyChainKey.accessToken
        )
        let refreshTokenUpdated = self.keychain.updateItem(
            token: self.reissuanceData?.refreshToken ?? "",
            key: Const.KeyChainKey.refreshToken
        )
        let authorityUpdated = self.keychain.updateItem(
            token: self.reissuanceData?.authority ?? "",
            key: Const.KeyChainKey.authority
        )
        
        if accessTokenUpdated && refreshTokenUpdated && authorityUpdated {
            print("keychain update success")
        } else {
            print("keychain update faild")
        }
    }
}
