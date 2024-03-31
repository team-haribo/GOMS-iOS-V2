//
//  AuthServices.swift
//  Service
//
//  Created by 새미 on 3/31/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum AuthServices {
    case signUp(param: SignUpRequest)
    case signIn(idToken: String, param: SignInRequest)
    case refreshToken(idToken: String)
    case sendAuthNumber(idToken: String, param: SendAuthNumberRequest)
    case verifyAuthNumber(idToken: String, param: VerifyAuthNumberRequest)
}

extension AuthServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .signUp:
            return "/auth/signup"
        case .signIn:
            return "/auth/signin"
        case .refreshToken:
            return "/auth/"
        case .sendAuthNumber:
            return "/auth/email/send"
        case .verifyAuthNumber:
            return "/auth/email/verify"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signUp,
             .signIn,
             .sendAuthNumber:
            return .post
        case .refreshToken:
            return .patch
        case .verifyAuthNumber:
            return .get
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .signUp(let param):
            return .requestJSONEncodable(param)
        case .signIn(_ , let param):
            return .requestJSONEncodable(param)
        case .refreshToken:
            return .requestPlain
        case .sendAuthNumber(_ , let param):
            return .requestJSONEncodable(param)
        case .verifyAuthNumber(_ , let param):
            return .requestJSONEncodable(param)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signIn(let idToken, _),
             .sendAuthNumber(let idToken, _),
             .verifyAuthNumber(let idToken, _):
            return [
                "idToken": idToken,
                "Content-Type": "application/json"
            ]
        case .refreshToken(let idToken):
            return ["idToken": idToken]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

