//
//  OutingServices.swift
//  Service
//
//  Created by 새미 on 4/18/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum OutingServicess {
    case outing(authorization: String)
    case outingList(authorization: String)
    case outingCount(authorization: String)
    case outingSearch(authorization: String)
    case outingValidation(authorization: String)
}

extension OutingServicess: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL) ?? URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .outing:
            return "/outing/{outingUUID}"
        case .outingList:
            return "/outing/"
        case .outingCount:
            return "/outing/count"
        case .outingSearch:
            return "/outing/search"
        case .outingValidation:
            return "/outing/validation"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .outingList,
             .outingCount,
             .outingSearch,
             .outingValidation:
            return .get
        case .outing:
            return .post
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .outing:
            return .requestPlain
        case .outingList:
            return .requestPlain
        case .outingCount:
            return .requestPlain
        case .outingSearch(let s):
            return .requestParameters(parameters: ["s": s], encoding: URLEncoding.queryString)
        case .outingValidation:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}


