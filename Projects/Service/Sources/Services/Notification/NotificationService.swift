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
    case postFcmToken(fcmToken: String, authorization: String)
}

extension NotificationServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-12fhqa2bln49rbi0.sel5.cloudtype.app/api/v2/notification/token")!
    }

    public var path: String {
        switch self {
        case .postFcmToken(let fcmToken, _):
            return "\(fcmToken)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .postFcmToken:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case .postFcmToken:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .postFcmToken(_, let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        }
    }
}
