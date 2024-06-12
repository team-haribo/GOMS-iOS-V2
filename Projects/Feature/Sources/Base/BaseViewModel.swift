//
//  BaseViewModel.swift
//  Feature
//
//  Created by 새미 on 4/23/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service
import Foundation

public class BaseViewModel {
    public let keyChain = KeyChain()
    let gomsRefreshToken = GOMSRefreshToken.shared
    public lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")
    public var isLogin: Bool {
        return !accessToken.isEmpty
    }
    
    public init() {}
}
