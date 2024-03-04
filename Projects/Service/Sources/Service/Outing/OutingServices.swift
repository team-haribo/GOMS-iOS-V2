//
//  OutingServices.swift
//  Service
//
//  Created by 새미 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum OutingServices {
    case outing(authorization: String, outingUUID: UUID)
    case outingList(authorization: String)
    case outingCount(authorization: String)
    case outingSearch(authorization: String, s: String)
    case outingValidation(anthorization: String)
}

extension OutingServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .outing:
            return "/"
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
        case .outing:
            return .post
        case .outingList, .outingCount, .outingSearch, .outingValidation:
            return .get
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .outing, .outingList, .outingCount, .outingValidation:
            return .requestPlain
        case let .outingSearch(_, s):
            return .requestParameters(parameters: ["s" : s ], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .outing(let authorization, _), .outingList(let authorization), .outingCount(let authorization), .outingSearch(let authorization, _):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
