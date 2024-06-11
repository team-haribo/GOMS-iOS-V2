//
//  AccountServices.swift
//  Service
//
//  Created by 새미 on 4/21/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum AccountServices {
    case newPassword(param: NewPasswordRequest)
    case changPassword(param: ChangPasswordRequest, authorization: String)
    case withdraw(password: String, authorization: String)
}

extension AccountServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://357d-39-114-169-106.ngrok-free.app/api/v2/account")!
    }
    
    public var path: String {
        switch self {
        case .newPassword:
            return "/new-password"
        case .changPassword:
            return "/change-password"
        case .withdraw(let password, _):
            return "/withdraw/\(password)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .newPassword, .changPassword:
            return .patch
        case .withdraw:
            return .delete
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .newPassword(let param):
            return .requestJSONEncodable(param)
        case .changPassword(let param, _):
            return .requestJSONEncodable(param)
        case .withdraw:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .newPassword:
            return ["Content-Type": "application/json"]
        case .changPassword(_, let authorization),
             .withdraw(_, let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
