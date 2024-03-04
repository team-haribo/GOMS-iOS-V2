//
//  OutingSearchModel.swift
//  Service
//
//  Created by 새미 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct OutingSearchModel: Codable {
    let data: OutingSearchResponse
}

struct OutingSearchResponse: Codable {
    let accountIdx: UUID
    let name: String
    let major: String
    let grade: Int
    let gender: String
    let profileUrl: String?
    let createdTime: Data
}
