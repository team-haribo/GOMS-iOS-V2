//
//  OutingCountModel.swift
//  Service
//
//  Created by 새미 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

struct OutingCountModel: Codable {
    let data: OutingCountResponse
}

struct OutingCountResponse: Codable {
    let outingCount: Int
}
