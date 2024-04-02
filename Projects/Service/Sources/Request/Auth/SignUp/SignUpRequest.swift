//
//  SignUpRequest.swift
//  Service
//
//  Created by 새미 on 3/31/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct SignUpRequest: Codable {
    var email: String
    var password: String
    var name: String
    var gender: String
    var major: String
    
    public init(email: String, password: String, name: String, gender: String, major: String) {
        self.email = email
        self.password = password
        self.name = name
        self.gender = gender
        self.major = major
    }
}
