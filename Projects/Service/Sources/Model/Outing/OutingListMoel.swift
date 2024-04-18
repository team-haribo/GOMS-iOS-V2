//
//  OutingListMoel.swift
//  Service
//
//  Created by 새미 on 4/18/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct OutingListModel: Codable {
    let data: OutingResponse
}

public struct OutingResponse: Codable {
    public let accountIdx: UUID
    public let name: String
    public let major: String
    public let grade: Int
    public let profileUrl: String?
    public let createdTime: String
}
