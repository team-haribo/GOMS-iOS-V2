//
//  LatecomerModel.swift
//  Service
//
//  Created by 새미 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct LatecomerModel: Codable {
    // 외출자 list data
}

struct LatecomerResponse: Codable {
    let accountIdx: UUID
    let name: String
    let major: String
    let grade: Int
    let gender: String
    let profileUrl: String?
}
