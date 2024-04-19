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
        // 밑에 코드는 나중에 리프레토큰 연결을 위해 남겨둠
        //["Content-Type": "application/json"]
        ["refreshToken": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJyZWZyZXNoIiwiaWF0IjoxNzEzNDg5MTAzLCJleHAiOjE3MTE3ODYxMzZ9.uxYQVbVPQ353xPRh0CTOq3DwMxtaXqrXz74mShrOMVU"]
        
    
        
    }
}

