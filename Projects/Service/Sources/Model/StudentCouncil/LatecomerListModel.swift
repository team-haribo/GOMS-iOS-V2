//
//  LatecomerListModel.swift
//  Service
//
//  Created by 새미 on 4/29/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct LatecomerListModel: Codable {
    let data: LatecomerListResponse
}

public struct LatecomerListResponse: Codable {
    public let accountIdx: UUID
    public let name: String
    public let grade: Int
    public let gender: String
    public let major: String
    public let profileUrl: String?
}
