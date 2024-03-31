//
//  SignInRequest.swift
//  Service
//
//  Created by 새미 on 3/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct SignInRequest: Codable {
    var email: String
    var password: String
    
    public init(_ email: String, _ password: String) {
        self.email = email
        self.password = password
    }
}
