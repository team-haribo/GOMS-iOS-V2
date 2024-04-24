//
//  OutingServices.swift
//  Service
//
//  Created by 새미 on 4/18/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum OutingServices {
    case outing(authorization: String)
    case outingList(authorization: String)
    case outingSearch(name: String?, authorization: String)
    case outingValidation(authorization: String)
}

extension OutingServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .outing:
            return "/outing/{outingUUID}"
        case .outingList:
            return "/outing/"
        case .outingSearch:
            return "/outing/search"
        case .outingValidation:
            return "/outing/validation"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .outingList,
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
        case .outingSearch(let name, _):
            return .requestParameters(parameters: ["name": name ?? ""], encoding: URLEncoding.queryString)
        case .outingValidation:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .outingList(let authorization),
                .outingValidation(let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}


