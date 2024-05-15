//
//  SearchStudentRequest.swift
//  Service
//
//  Created by 새미 on 5/2/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

public struct SearchStudentRequest: Codable {
    var grade: Int?
    var gender: String?
    var name: String?
    var isBlackList: Bool?
    var authority: String?
    var major: String?
    
    public init(grade: Int?, gender: String?, name: String?, isBlackList: Bool?, authority: String?, major: String?) {
        self.grade = grade
        self.gender = gender
        self.name = name
        self.isBlackList = isBlackList
        self.authority = authority
        self.major = major
    }
}
