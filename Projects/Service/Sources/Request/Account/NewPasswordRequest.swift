//
//  NewPasswordRequest.swift
//  Service
//
//  Created by 새미 on 4/21/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct NewPasswordRequest: Codable {
    var email: String
    var newPassword: String
    
    public init(email: String, newPassword: String) {
        self.email = email
        self.newPassword = newPassword
    }
}
