//
//  NewPasswordViewModel.swift
//  Feature
//
//  Created by 새미 on 4/21/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service

public final class NewPasswordViewModel {
    private let accountProvider = MoyaProvider<AccountServices>()
    
    let keyChain = KeyChain()
    let gomsRefreshToken = GOMSRefreshToken.shared
    lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")
    
    private var email: String  = ""
    private var password: String = ""
    
    func setupEmail(email: String) {
        self.email = email
    }
    
    func setupPassword(password: String, checkPassword: String){
        guard password == checkPassword else { return }
    }
    
    func newPassword(completion: @escaping (Bool) -> Void) {
        let param = NewPasswordRequest.init(email: email, newPassword: password)
        
        accountProvider.request(.newPassword(param: param, authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 204:
                    print("NO CONTENT")
                    completion(true)
                case 404:
                    print("존재하지 않는 사용자일때.")
                    completion(false)
                case 400:
                    print("변경하려는 비밀번호가 이전 비밀번호와 같을 때")
                    completion(false)
                default:
                    print(result)
                    completion(false)
                }
                print("")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
