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
    
    var userSearchList: [StudentListResponse] = []
    var userSearchListDatas: [UserData] = []
    
    private var grade: Int?
    private var gender: String?
    private var isBlackList: Bool?
    private var authority: String?
    private var major: String?
    
    // MARK: - Setting
    func setupGrade(grade: Int?) {
        self.grade = grade!
        print("graddddddddd")
    }
    
    func setupGender(gender: String?) {
        self.gender = gender!
    }

    func setupIsBlackList(isBlackList: Bool?) {
        self.isBlackList = isBlackList!
    }
    
    func setupAuthority(authority: String?) {
        self.authority = authority!
    }
    
    func setupMajor(major: String?) {
        self.major = major!
    }
    
    func resetInfo() {
        self.grade = nil
        self.gender = nil
        self.isBlackList = nil
        self.authority = nil
        self.major = nil
    }
    
    // MARK: - Get User List
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
    
    // MARK: - Change Student Council Authority
    func changeAuthority(index: Int, completion: @escaping () -> Void) {
        self.getUserList {
            let selectedUser = self.userList[index]
            let accountIdx = selectedUser.accountIdx
            let authority = selectedUser.authority
            
            let param = AuthorityRequest.init(accountIdx: accountIdx, authority: authority)
            self.studentCouncilProvider.request(.editAuthority(authorization: self.accessToken, param: param)) { response in
                switch response {
                case .success(let result):
                    let statusCode = result.statusCode
                    switch statusCode {
                    case 200..<300:
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
    }
    
    // MARK: - Black List
    func blackList(index: Int, completion: @escaping () -> Void) {
        self.getUserList {
            let selectedUser = self.userList[index]
            let accountIdx = selectedUser.accountIdx
            
            self.studentCouncilProvider.request(.changeBlackList(authorization: self.accessToken, accountIdx: accountIdx)) { response in
                switch response {
                case .success(let result):
                    let statusCode = result.statusCode
                    switch statusCode {
                    case 200..<300:
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
    
    // MARK: - Delete Black List
    func cancelBlackList(index: Int, completion: @escaping () -> Void) {
        self.getUserList {
            let selectedUser = self.userList[index]
            let accountIdx = selectedUser.accountIdx
            
            self.studentCouncilProvider.request(.cancelBlackList(authorization: self.accessToken, accountIdx: accountIdx)) { response in
                switch response {
                case .success(let result):
                    let statusCode = result.statusCode
                    switch statusCode {
                    case 200..<300:
                        print("Reset content")
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
    
    // MARK: - Search User
    func serachStudent(searchString: String, completion: @escaping () -> Void) {
        let parm = SearchStudentRequest.init(grade: grade, gender: gender, name: searchString, isBlackList: isBlackList ?? false, authority: authority, major: major)
        
        studentCouncilProvider.request(.searchStudent(authorization: self.accessToken, parm: parm)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                do {
                    print("searchString: \(searchString)")
                    print(self.grade)
                    print(self.gender)
                    print(self.isBlackList)
                    print(self.authority)
                    print(self.major)
                    self.userSearchList = try JSONDecoder().decode([StudentListResponse].self, from: responseData)
                    self.userSearchListDatas = self.userSearchList.map { UserData(id: $0.accountIdx, name: $0.name, profileImageURL: $0.profileUrl, gender: $0.gender, grade: $0.grade, major: $0.major, authority: $0.authority, isBlackList: $0.isBlackList) }
                    print("User Search: \(self.userSearchList)")
                    completion()
                } catch(let err) {
                    print(String(describing: err))
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    print("ok")
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 403:
                    print("학생회 계정이 아닌데 요청할 경우")
                default:
                    print(result)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

