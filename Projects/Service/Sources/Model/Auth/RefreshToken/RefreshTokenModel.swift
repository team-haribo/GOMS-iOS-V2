//
//  RefreshTokenModel.swift
//  Service
//
//  Created by 새미 on 3/31/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct RefreshTokenModel: Codable {
    let data: RefreshTokenResponse
}

struct RefreshTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let accessTokenExp: String
    let refreshTokenExpr: String
    let authority: String
}
