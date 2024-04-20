//
//  SignInViewModel.swift
//  Feature
//
//  Created by 새미 on 4/1/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service

public final class SignInViewModel {
    private let authProvider = MoyaProvider<AuthServices>()
    
    let gomsToken = KeyChain()
    var userData: SignInModel?
    
    private var email: String = ""
    private var passsword: String = ""
    
    func setupEmail(email: String) {
        self.email = "\(email)@gsm.hs.kr"
    }
    
    func setupPassword(password: String) {
        self.passsword = password
    }
    
    func signIn(completion: @escaping (Bool) -> Void) {
        let param = SignInRequest.init(email: email, password: passsword)
        authProvider.request(.signIn(param: param)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                do {
                    switch statusCode {
                    case 200:
                        print("OK")
                        let signInResponse = try result.map(SignInResponse.self)
                        self.gomsToken.create(key: Const.KeyChainKey.accessToken, token: signInResponse.accessToken)
                        self.gomsToken.create(key: Const.KeyChainKey.refreshToken, token: signInResponse.refreshToken)
                        self.gomsToken.create(key: Const.KeyChainKey.authority, token: signInResponse.authority)
                        completion(true)
                    case 500:
                        print("SERVER ERROR")
                        completion(false)
                    default:
                        print(result)
                        completion(false)
                    }
                } catch {
                    print("error")
                    completion(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
}
