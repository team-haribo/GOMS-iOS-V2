//
//  NotificationRequest.swift
//  Service
//
//  Created by 서지완 on 12/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct NotificationRequest: Codable {
    var fcmToken: String

    public init(fcmToken: String) {
        self.fcmToken = fcmToken
    }
}
