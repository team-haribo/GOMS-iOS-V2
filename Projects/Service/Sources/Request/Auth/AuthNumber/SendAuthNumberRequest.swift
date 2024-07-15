//
//  SendAuthCodeRequest.swift
//  Service
//
//  Created by 새미 on 3/31/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct SendAuthCodeRequest: Codable {
    var email: String
    var emailStatus: String
    
    public init(email: String, emailStatus: String) {
        self.email = email
        self.emailStatus = emailStatus
    }
}
