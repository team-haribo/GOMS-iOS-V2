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
    case newPassword(param: NewPasswordRequest, authorization: String)
}

extension AccountServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .newPassword:
            return "/account/new-password"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .newPassword:
            return .patch
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .newPassword(let param, _):
            return .requestJSONEncodable(param)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .newPassword(_, let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
