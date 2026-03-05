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
        guard let urlString = Bundle.main.infoDictionary?["SchoolBaseURL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("AccountAPI URL 불러오기 실패")
        }

        print("🌍 Account baseURL:", url.absoluteString)
        return url
    }

    public var path: String {
        let p: String

        switch self {
        case .newPassword:
            p = "/account/new-password"
        case .changPassword:
            p = "/account/change-password"
        case .withdraw(let password, _):
            p = "/account/withdraw/\(password)"
        }

        print("📡 Account 요청 URL:", baseURL.absoluteString + p)
        return p
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
        }
    }
}
  
