//
//  GOMSToken.swift
//  Feature
//
//  Created by 새미 on 4/8/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service
import Security
import Foundation

class Keychain {
    func create(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(query)
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    func read() {
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
}
