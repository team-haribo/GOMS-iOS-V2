//
//  LogoutServices.swift
//  Service
//
//  Created by 서지완 on 4/17/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Foundation

public enum LogoutServices {
    case logoutToken(refreshToken: String)
}

extension LogoutServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2/auth")!
    }

    public var path: String {
        switch self {
        case .logoutToken:
            return "/"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .logoutToken:
            return .delete
        }
    }

    public var task: Task {
           switch self {
           case let .logoutToken(refreshToken):
               let parameters: [String: Any] = ["refreshToken": refreshToken]
               return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
           }
       }

    public var headers: [String: String]? {
        //["Content-Type": "application/json"]
        ["refreshToken": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJhY2Nlc3MiLCJhdXRob3JpdHkiOiJST0xFX1NUVURFTlRfQ09VTkNJTCIsImlhdCI6MTcxMzQyNzA0NywiZXhwIjoxNzEzNDM3ODQ3fQ.qBZ4yLt12mtrHlUgYt7WmYg8rCyoVtMRWem7zM-BQ4Y"]
        
    
        
    }
}

