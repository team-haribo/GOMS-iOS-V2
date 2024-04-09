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
        self.email = "\(email)@gsm.hs.kr"
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
    }
    
    func sendAuthNumber(completion: @escaping (Bool) -> Void) {
        let param = SendAuthNumberRequest.init(email: email)
        authProvider.request(.sendAuthNumber(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    let statusCode = result.statusCode
                    switch statusCode {
                    case 204:
                        print("No Content")
                        completion(true)
                    case 404:
                        print("GOMS 회원이 아닌 사용자가 이메일 인증 요청을 한 경우")
                        completion(false)
                    case 429:
                        print("이메일 요청이 5번을 초과할 경우")
                        completion(false)
                    case 500:
                        print("SERVER ERROR")
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
    
    func verifyAuthNumber(completion: @escaping (Bool) -> Void) {
        authProvider.request(.verifyAuthNumber(emaiil: email, authCode: authnNumber)) { response in
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
    
    func SignUp(completion: @escaping (Bool) -> Void) {
        let param = SignUpRequest.init(email: email, password: password, name: name, gender: gender, major: major)
        authProvider.request(.signUp(param: param)) { response in
            switch response {
            case .success(let result):
                do {
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
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
}
