//
//  NotificationModel.swift
//  Service
//
//  Created by 서지완 on 12/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct NotificationModel: Codable {
    let data: NotificationResponse
}

public struct NotificationResponse: Codable {
    public let outingStatus: Bool
}
