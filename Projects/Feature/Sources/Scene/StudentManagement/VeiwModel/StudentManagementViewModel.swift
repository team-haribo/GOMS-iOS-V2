//
//  StudentManagementViewModel.swift
//  Feature
//
//  Created by 새미 on 5/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya
import Service

struct UserData {
    let id: UUID
    let name: String
    let profileImageURL: String?
    let gender: String
    let grade: Int
    let major: String
    let authority: String
    let isBlackList: Bool
}

public final class StudentManagementViewModel: BaseViewModel {
    
    private let studentCouncilProvider = MoyaProvider<StudentCouncilServices>()
    
    var userList: [StudentListResponse] = []
    var userListDatas: [UserData] = []
    
    func getUserList(completion: @escaping () -> Void) {
        studentCouncilProvider.request(.studentList(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    do {
                        self.userList = try JSONDecoder().decode([StudentListResponse].self, from: responseData)
                        self.userListDatas = self.userList.map { UserData(id: $0.accountIdx, name: $0.name, profileImageURL: $0.profileUrl, gender: $0.gender, grade: $0.grade, major: $0.major, authority: $0.authority, isBlackList: $0.isBlackList) }
                        completion()
                    } catch(let err) {
                        print(String(describing: err))
                    }
                    print("success")
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 403:
                    print("학생회 계정이 아닐 경우")
                default:
                    print(result)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

