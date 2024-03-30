//
//  SignUpRequest.swift
//  Service
//
//  Created by 새미 on 3/31/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let password: String
    let name: String
    let gender: String
    let major: String
}
