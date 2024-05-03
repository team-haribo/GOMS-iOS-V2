//
//  ProfileModel.swift
//  Service
//
//  Created by 서지완 on 5/3/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct ProfileModel: Codable {
    let date: ProfileResponse
}

public struct ProfileResponse: Codable {
    public let name: String
    public let grade: Int
    public let major: String
    public let gender: String
    public let authority: String
    public let profileUrl: String?
    public let lateCount: Int
    public let isOuting: Bool
    public let isBlackList: Bool
}
