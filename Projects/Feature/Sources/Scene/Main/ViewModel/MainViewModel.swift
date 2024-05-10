//
//  MainViewModel.swift
//  Feature
//
//  Created by 새미 on 4/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service
import Foundation

struct LatecomerData {
    let profileImageURL: String?
    let name: String
    let grade: Int
    let major: String
}

public final class MainViewModel: BaseViewModel {
    private let lateProvider = MoyaProvider<LateService>()
    private let outingProvider = MoyaProvider<OutingServices>()

    var lateList: [LatecomerResponse] = []
    var lateListDatas: [LatecomerData] = []
    
    var outingList: [OutingListResponse] = []
    var outingListDatas: [OutingListData] = []
    
    func getLateList(completion: @escaping () -> Void) {
        lateProvider.request(.lateRank(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                do {
                    self.lateList = try JSONDecoder().decode([LatecomerResponse].self, from: responseData)
                    self.lateListDatas = self.lateList.map { LatecomerData(profileImageURL: $0.profileUrl, name: $0.name, grade: $0.grade, major: $0.major) }
                    completion()
                } catch(let err) {
                    print(String(describing: err))
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("OK")
                    let adminVC = AdminMainViewController()
                    let userVC = MainViewController()
                    adminVC.showLatecomers()
                    userVC.showLatecomers()
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 404:
                    print("지각자 없음")
                    let adminVC = AdminMainViewController()
                    let userVC = MainViewController()
                    adminVC.nilLatecomers()
                    userVC.nilLatecomers()
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
}
