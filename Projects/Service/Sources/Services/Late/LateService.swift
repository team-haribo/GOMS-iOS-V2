//
//  LateService.swift
//  Service
//
//  Created by 새미 on 4/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum LateService {
    case lateRank(authorization: String)
}

extension LateService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://ec38-210-218-52-13.ngrok-free.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .lateRank:
            return "/late/rank"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .lateRank:
            return .get
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .lateRank:
            return.requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .lateRank(let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
