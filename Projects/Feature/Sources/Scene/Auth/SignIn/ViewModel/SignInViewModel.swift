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
    
    private var email: String = ""
    private var passsword: String = ""
    
    func setupEmail(email: String) {
        self.email = "\(email)@gsm.hs.kr"
    }
    
    func setupPassword(password: String) {
        self.passsword = password
    }
    
    func sendAuthNumber(completion: @escaping (Bool) -> Void) {
        let param = SendAuthNumberRequest.init(email: email)
        authProvider.request(.sendAuthNumber(param: param)) { response in
            switch response {
            case .success:
                do {
                    completion(true)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
    
    func signIn(completion: @escaping (Bool) -> Void) {
        let param = SignInRequest.init(email: email, password: passsword)
        authProvider.request(.signIn(param: param)) { response in
            switch response {
            case .success:
                do {
                    // 처리
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
}
