//
//  VerifyAuthNumber.swift
//  Service
//
//  Created by 새미 on 3/31/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct VerifyAuthNumberRequest: Codable {
    var email: String
    var authCode: String
    
    public init(email: String, authCode: String) {
        self.email = email
        self.authCode = authCode
    }
}
