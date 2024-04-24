//
//  OutingStatusViewModel.swift
//  Feature
//
//  Created by 새미 on 4/19/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service
import Foundation

struct OutingListData {
    let id: UUID
    let profileImageURL: String?
    let name: String
    let grade: Int
    let major: String
    let outingTime: String
}

public final class OutingViewModel: BaseViewModel {
    private let outingProvider = MoyaProvider<OutingServices>()
    private let studentCouncilProvider = MoyaProvider<StudentCouncilServices>()

    var outingList: [OutingListResponse] = []
    var outingListDatas: [OutingListData] = []
    
    var outingSearchList: [OutingSearchResponse] = []
    var outingSearchListDatas: [OutingListData] = []
    
    func getOutingList(completion: @escaping () -> Void) {
        outingProvider.request(.outingList(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                do {
                    self.outingList = try JSONDecoder().decode([OutingListResponse].self, from: responseData)
                    self.outingListDatas = self.outingList.map { OutingListData(id: $0.accountIdx, profileImageURL: $0.profileUrl, name: $0.name, grade: $0.grade, major: $0.major, outingTime: $0.createdTime) }
                    completion()
                } catch(let err) {
                    print(String(describing: err))
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("OK")
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 404:
                    print("외출한 사람이 없을 경우")
                case 500:
                    print("SERVER ERROR")
                default:
                    print(result)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func searchStudent(searchString: String, completion: @escaping () -> Void) {
        outingProvider.request(.outingSearch(name: searchString, authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                do {
                    self.outingSearchList = try JSONDecoder().decode([OutingSearchResponse].self, from: responseData)
                    self.outingSearchListDatas = self.outingSearchList.map { OutingListData(id: $0.accountIdx, profileImageURL: $0.profileUrl, name: $0.name, grade: $0.grade, major: $0.major, outingTime: $0.createdTime) }
                    completion()
                } catch(let err) {
                    print(String(describing: err))
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("OK")
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 500:
                    print("SERVER-ERROR")
                default:
                    print(result)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func deleteOutingStudent(index: Int, completion: @escaping () -> Void) {
        let deleteStudent = outingList[index]
        let accountIdx = deleteStudent.accountIdx

        studentCouncilProvider.request(.deleteOuting(authorization: accessToken, accountIdx: accountIdx)) { response in
            switch response {
            case .success(let result):
                if result.statusCode == 205 {
                    self.outingListDatas.remove(at: index)
                    completion()
                } else if result.statusCode == 401 {
                    self.gomsRefreshToken.tokenReissuance()
                } else if result.statusCode == 403 {
                    print("학생회 계정이 아닌데 요청할 경우")
                } else {
                    print("SERVER ERROR")
                }
            case .failure(let err):
                print("외출자 삭제 중 오류 발생: \(err.localizedDescription)")
            }
        }
    }
}
