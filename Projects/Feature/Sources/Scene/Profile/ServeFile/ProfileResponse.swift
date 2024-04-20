//
//  ProfileResponse.swift
//  Service
//
//  Created by 서지완 on 4/17/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct ProfileResponse: Codable {
    let name: String
    let grade: Int
    let major: String
    let gender: String
    let authority: String
    let profileUrl: String?
    let lateCount: Int
    let isOuting: Bool
    let isBlackList: Bool
}
