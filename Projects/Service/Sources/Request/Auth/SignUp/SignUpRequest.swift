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
    
    init(_ email: String, _ password: String, _ name: String, _ gender: String, _ major: String) {
        self.email = email
        self.password = password
        self.name = name
        self.gender = gender
        self.major = major
    }
}
