//
//  AuthorityRequest.swift
//  Service
//
//  Created by 새미 on 5/2/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct AuthorityRequest: Codable {
    var accountIdx: UUID
    var authority: String
    
    public init(accountIdx: UUID, authority: String) {
        self.accountIdx = accountIdx
        self.authority = authority
    }
}
