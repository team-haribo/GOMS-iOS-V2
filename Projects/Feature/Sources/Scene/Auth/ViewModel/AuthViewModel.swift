//
//  AuthViewModel.swift
//  Feature
//
//  Created by 새미 on 5/2/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service
import Foundation

public final class AuthViewModel: BaseViewModel {
    
    private let authProvider = MoyaProvider<AuthServices>()
    private let accountProvider = MoyaProvider<AccountServices>()
    
    public override init() {}
    
    var userData: SignInModel?
    private var email: String = ""
    public let profileModel = ProfileViewModel()
    
    private var password: String = ""
    private var authCode: String = ""
    private var newPassword: String = ""
    private var newServePassword: String = ""
    private var name: String = ""
    private var gender: String = ""
    private var major: String = ""
    private var emailStatus: String = ""
    
    private var passwordServe: String = ""
    
    func setupEmailStatus(emailStatus: String) {
        self.emailStatus = emailStatus
    }
    
    func setupEmail(email: String) {
        self.email = "\(email)@gsm.hs.kr"
    }
    
    func setupPassword(password: String) {
        self.password = password
    }
    
    func setupAuthCode(authCode: String) {
        self.authCode = authCode
    }
    
    func setupNewPassword(newPassword: String, checkPassword: String) {
        guard newPassword == checkPassword else { return }
        self.newPassword = newPassword
    }
    
    func setupNewServePassword(newPassword: String, checkPassword: String) {
        guard newPassword == checkPassword else { return }
        self.newServePassword = newPassword
    }
    
    func setupName(name: String) {
        self.name = name
    }
    
    func setupGender(gender: String) {
        self.gender = gender
    }
    
    func setupMajor(major: String) {
        self.major = major
    }
    
    // MARK: - Sign In
    func signIn(completion: @escaping (Int, String?) -> Void) {
        let param = SignInRequest(email: email, password: password)
        authProvider.request(.signIn(param: param)) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.global().async {
                var authority: String? = nil
                switch response {
                case .success(let result):
                    let statusCode = result.statusCode
                    do {
                        switch statusCode {
                        case 200:
                            print(self.password)
                            let signInResponse = try result.map(SignInResponse.self)
                            self.keyChain.create(key: Const.KeyChainKey.accessToken, token: signInResponse.accessToken)
                            self.keyChain.create(key: Const.KeyChainKey.refreshToken, token: signInResponse.refreshToken)
                            self.keyChain.create(key: Const.KeyChainKey.authority, token: signInResponse.authority)
                            authority = signInResponse.authority
                            
                            completion(statusCode, authority)
                        default:
                            break
                        }
                    } catch {
                        print("Error parsing SignInResponse: \(error)")
                    }
                    DispatchQueue.main.async {
                        completion(statusCode, authority)
                    }
                    
                case .failure(let err):
                    print("Network error: \(err.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(0, nil)
                    }
                }
            }
        }
    }

    // MARK: - Send Auth Code
    func sendAuthCode(completion: @escaping (Bool, Int) -> Void) {
        let param  = SendAuthCodeRequest(email: email, emailStatus: emailStatus)
        authProvider.request(.sendAuthCode(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let statusCode = result.statusCode
                    switch statusCode {
                    case 204:
                        print("success")
                        completion(true, statusCode)
                    case 404:
                        print("존재하지 않는 사용자일때")
                        completion(false, statusCode)
                    case 429:
                        print("이메일 요청이 5번을 초과할 경우")
                        completion(false, statusCode)
                    default:
                        print(result)
                        completion(false, statusCode)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false, 0)
            }
        }
    }
    
    // MARK: - Verify Auth Code
    func verifyAuthCode(completion: @escaping (Bool) -> Void) {
        authProvider.request(.verifyAuthNumber(email: email, authCode: authCode)) { response in
            switch response {
            case .success(let result):
                do {
                    let statusCode = result.statusCode
                    switch statusCode {
                    case 200..<300:
                        print("OK")
                        completion(true)
                    case 404:
                        print("인증 코드를 찾을 수 없을때 / 인증되지 않은 사용자일때 / 찾을 수 없는 사용자 일때")
                        completion(false)
                    case 429:
                        print("인증번호 검증 요청이 5번을 초과할 경우")
                        completion(false)
                    case 500:
                        print("SERVER ERROR")
                        completion(false)
                    default:
                        print(result)
                        completion(false)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
    
    // MARK: - New Password
    func newPassword(completion: @escaping (Bool, Int) -> Void) {
        let param = NewPasswordRequest.init(email: email, newPassword: newServePassword)
        accountProvider.request(.newPassword(param: param)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 204:
                    print("NO CONTENT")
                    print(statusCode)
                    completion(true, statusCode)
                    print("금방찍음")
                case 404:
                    print("존재하지 않는 사용자일때")
                    completion(false, statusCode)
                    print(statusCode)
                    print("금방찍음")
                case 400:
                    print("변경하려는 비밀번호가 이전 비밀번호와 같을 때")
                    completion(false, statusCode)
                    print(statusCode)
                    print("금방찍음")
                case 500:
                    print("SERVER ERROR")
                    print(statusCode)
                    completion(false, statusCode)
                    print("금방찍음")
                default:
                    print(result)
                    completion(false, statusCode)
                    print(statusCode)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func changNewPassword(completion: @escaping (Bool, Int) -> Void) {
        let param = ChangPasswordRequest(password: password, newPassword: newPassword)
        accountProvider.request(.changPassword(param: param, authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                print(statusCode)
                switch statusCode {
                case 204:
                    print("NO CONTENT")
                    completion(true, statusCode)
                case 404:
                    print("존재하지 않는 사용자일때")
                    completion(false, statusCode)
                case 400:
                    print("변경하려는 비밀번호가 이전 비밀번호와 같을 때")
                    completion(false, statusCode)
                case 500:
                    print("SERVER ERROR")
                    completion(false, statusCode)
                default:
                    print(result)
                    completion(false, statusCode)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false, 0)
            }
        }
    }
    
    // MARK: - Sign Up
    func signUp(completion: @escaping (Bool) -> Void) {
        let param = SignUpRequest.init(email: email, password: newPassword, name: name, gender: gender, major: major)
        authProvider.request(.signUp(param: param)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 201:
                    print("Created")
                    completion(true)
                case 500:
                    print("SERVER ERROR")
                    completion(false)
                default:
                    print(result)
                    completion(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
}

