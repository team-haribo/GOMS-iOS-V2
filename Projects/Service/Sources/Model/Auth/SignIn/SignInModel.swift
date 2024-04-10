//
//  SignInModel.swift
//  Service
//
//  Created by 새미 on 3/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct SignInModel: Codable {
    let data: SignInResponse
}

public struct SignInResponse: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let accessTokenExp: String
    public let refreshTokenExp: String
    public let authority: String
}
