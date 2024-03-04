//
//  OutingListModel.swift
//  Service
//
//  Created by 새미 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct OutingListModel: Codable {
    public let data: OutingListResponse
}

public struct OutingListResponse: Codable {
    public let accountIdx: UUID
    public let name: String
    public let major: String
    public let grade: Int
    public let gender: Int
    public let profileUrl: String?
    public let createdTime: Data
}
