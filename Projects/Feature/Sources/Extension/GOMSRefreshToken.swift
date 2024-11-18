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
    private var statusCode: Int = 0
    private var reissuanceData: SignInResponse?
    private lazy var refreshToken = "Bearer " + (keychain.read(key: Const.KeyChainKey.refreshToken) ?? "")

    public func tokenReissuance(completion: @escaping (Bool) -> Void) {
        authProvider.request(.refreshToken(refreshToken: refreshToken)) { [weak self] response in
            guard let self = self else {
                completion(false)
                return
            }

            switch response {
            case .success(let result):
                self.statusCode = result.statusCode
                switch self.statusCode {
                case 200:
                    do {
                        self.reissuanceData = try result.map(SignInResponse.self)
                        self.updateKeychainToken()
                        completion(true)
                    } catch(let err) {
                        print(String(describing: err))
                        completion(false)
                    }
                case 400, 401, 404:
                    print("token error")
                    completion(false)
                default:
                    print("token error")
                    completion(false)
                }
            case .failure(let err):
                print(String(describing: err))
                completion(false)
            }
        }
    }

    private func updateKeychainToken() {
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
            print("keychain update failed")
        }
    }
}
