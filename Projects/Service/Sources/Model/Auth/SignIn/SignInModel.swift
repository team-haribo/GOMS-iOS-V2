//
//  SignInModel.swift
//  Service
//
//  Created by 새미 on 3/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct SignInModel: Codable {
    let data: SignInResponse
}

struct SignInResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let accessTokenExp: String
    let refreshTokenExp: String
    let authority: String
}
