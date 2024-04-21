//
//  AuthServices.swift
//  Service
//
//  Created by 새미 on 4/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum AuthServices {
    case signUp(param: SignUpRequest)
    case signIn(param: SignInRequest)
    case refreshToken(refreshToken: String)
    case sendAuthNumber(param: SendAuthNumberRequest)
    case verifyAuthNumber(emaiil: String, authCode: String)
}

extension AuthServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
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
        case .signIn(let param):
            return .requestJSONEncodable(param)
        case .refreshToken:
            return .requestPlain
        case .sendAuthNumber(let param):
            return .requestJSONEncodable(param)
        case .verifyAuthNumber(let email, let authCode):
            return .requestParameters(parameters: ["email": email, "authCode": authCode], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .refreshToken(let refreshToken):
            return [
                "Content-Type": "application/json",
                "refreshToken": refreshToken
            ]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}


