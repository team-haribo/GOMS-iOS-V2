//
//  SignUpViewModel.swift
//  Feature
//
//  Created by 새미 on 4/1/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service

public final class SignUpViewModel {
    
    private let authProvider = MoyaProvider<AuthServices>()
    
    private var name: String = ""
    private var email: String = ""
    private var gender: String = ""
    private var major: String = ""
    private var password: String = ""
    private var authnNumber: String = ""
    
    func setupName(name: String) {
        self.name = name
    }
    
    func setupEmail(email: String) {
        self.email = email
    }
    
    func setupGender(gender: String) {
        self.gender = gender
    }
    
    func setupMajor(major: String) {
        self.major = major
    }
    
    func setupAuthNumber(authNumber: String) {
        self.authnNumber += authNumber
    }
    
    func setupPassword(password: String, checkPassword: String) {
        guard password == checkPassword else { return }
        SignUp()
    }
    
    func sendAuthNumber() {
        let param = SendAuthNumberRequest.init(email: email)
        authProvider.request(.sendAuthNumber(param: param)) { response in
            switch response {
            case .success:
                do {
                    return
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func verifyAuthNumber() {
        let param = VerifyAuthNumberRequest.init(email: email, authCode: authnNumber)
        authProvider.request(.verifyAuthNumber(param: param)) { response in
            switch response {
            case .success:
                do {
                    return
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func SignUp() {
        let param = SignUpRequest.init(email: email, password: password, name: name, gender: gender, major: major)
        authProvider.request(.signUp(param: param)) { response in
            switch response {
            case .success:
                do {
                    return
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
