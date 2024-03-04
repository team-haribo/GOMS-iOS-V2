//
//  LatecomerServices.swift
//  Service
//
//  Created by 새미 on 2/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

enum LatecomerServices {
    case lateRank(authorization: String)
}

extension LatecomerServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .lateRank:
            return "/late/rank"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .lateRank:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Moya.Task {
        switch self {
        case .lateRank:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .lateRank(let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        }
    }
}
