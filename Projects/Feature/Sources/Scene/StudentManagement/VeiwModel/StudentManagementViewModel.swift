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
    
    func changeAuthority(index: Int, completion: @escaping () -> Void) {
        let selectedUser = userList[index]
        let accountIdx = selectedUser.accountIdx
        let authority = selectedUser.authority
        
        let param = AuthorityRequest.init(accountIdx: accountIdx, authority: authority)
        studentCouncilProvider.request(.editAuthority(authorization: accessToken, param: param)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("success")
                    completion()
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 403:
                    print("학생회 계정이 아닌데 요청할 경우")
                case 404:
                    print("계정을 찾을 수 없을 경우")
                default:
                    print(result)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func blackList(index: Int, completion: @escaping () -> Void) {
        let selectedUser = userList[index]
        let accountIdx = selectedUser.accountIdx
        
        studentCouncilProvider.request(.changeBlackList(authorization: accessToken, accountIdx: accountIdx)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 201:
                    print("Created")
                    completion()
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 403:
                    print("학생회 계정이 아닌데 요청할 경우")
                case 404:
                    print("계정을 찾을 수 없을 경우")
                default:
                    print(result)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

