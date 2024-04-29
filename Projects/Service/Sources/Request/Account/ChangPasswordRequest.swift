//
//  ChangPasswordRequest.swift
//  Service
//
//  Created by 서지완 on 4/27/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct ChangPasswordRequest: Codable {
    var password: String
    var newPassword: String
    
    public init(password: String, newPassword: String) {
        self.password = password
        self.newPassword = newPassword
    }
}
