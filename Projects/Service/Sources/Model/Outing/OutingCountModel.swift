//
//  OutingCountModel.swift
//  Service
//
//  Created by 새미 on 4/18/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct OutingCountModel: Codable {
    let data: OutingCountResponse
}

public struct OutingCountResponse: Codable {
    public let outingCount: Int
}
