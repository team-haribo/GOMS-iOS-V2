//
//  OutingListModel.swift
//  Service
//
//  Created by 새미 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct OutingListModel: Codable {
    let data: OutingListResponse
}

struct OutingListResponse: Codable {
    let accountIdx: UUID
    let name: String
    let major: String
    let grade: Int
    let gender: Int
    let profileUrl: String?
    let createdTime: Data
}
