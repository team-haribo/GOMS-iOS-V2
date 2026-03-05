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
    case sendAuthCode(param: SendAuthCodeRequest)
    case verifyAuthNumber(email: String, authCode: String)
    case logoutToken(refreshToken: String)
}

extension AuthServices: TargetType {
    public var baseURL: URL {
        let url = URL(string: "http://gsmsv-1.yujun.kr:23346/api/v2")!
        return url
    }

    public var path: String {
        let p: String

        switch self {
        case .signUp:
            p = "/auth/signup"
        case .signIn:
            p = "/auth/signin"
        case .refreshToken:
            p = "/auth/"
        case .sendAuthCode:
            p = "/auth/email/send"
        case .verifyAuthNumber:
            p = "/auth/email/verify"
        case .logoutToken:
            p = "/auth"
        }

        return p
    }
    
    public var method: Moya.Method {
        switch self {
        case .signUp,
             .signIn,
             .sendAuthCode:
            return .post
        case .refreshToken:
            return .patch
        case .verifyAuthNumber:
            return .get
        case .logoutToken:
            return .delete
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
        case .sendAuthCode(let param):
            return .requestJSONEncodable(param)
        case .verifyAuthNumber(let email, let authCode):
            return .requestParameters(parameters: ["email": email, "authCode": authCode], encoding: URLEncoding.queryString)
        case let .logoutToken(refreshToken):
            let parameters: [String: Any] = ["refreshToken": refreshToken]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .refreshToken(let refreshToken),
             .logoutToken(let refreshToken):
            return [
                "Content-Type": "application/json",
                "refreshToken": refreshToken
            ]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

