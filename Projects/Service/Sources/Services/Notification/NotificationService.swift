//
//  NotificationService.swift
//  Service
//
//  Created by 서지완 on 12/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya

public enum NotificationServices {
    case getOuting
}

extension NotificationServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-12fhqa2bln49rbi0.sel5.cloudtype.app/api/v2/outing")!
    }

    public var path: String {
        switch self {
        case .getOuting:
            return "/date"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getOuting:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .getOuting:
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
