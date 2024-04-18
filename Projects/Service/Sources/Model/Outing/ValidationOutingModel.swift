//
//  ValidationOutingModel.swift
//  Service
//
//  Created by 새미 on 4/18/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct ValidationOutingModel: Codable {
    let data: ValidationOutingResponse
}

public struct ValidationOutingResponse: Codable {
    public let isOuting: Bool
}

