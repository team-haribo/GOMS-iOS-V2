//
//  BaseURL.swift
//  Service
//
//  Created by 새미 on 3/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct BaseURL {
    public static let baseURL = Bundle.main.object(forInfoDictionaryKey: "SERVER_HOST") as! String
}
