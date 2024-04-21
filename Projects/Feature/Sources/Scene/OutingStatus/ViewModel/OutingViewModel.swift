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

public final class OutingViewModel {
    private let outingProvider = MoyaProvider<OutingServices>()
    
    let keyChain = KeyChain()
    let gomsRefreshToken = GOMSRefreshToken.shared
    lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")

    var outingList: [OutingListResponse] = []
    var outingListDatas: [OutingListData] = []

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
    
    func countOuting() {
        outingProvider.request(.outingCount(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("OK")
                case 401:
                    print("만료된 accessToken일 경우")
                    print("유효하지 않은 accessToken일 경우")
                    self.gomsRefreshToken.tokenReissuance()
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
    
    func searchStudent() {
        outingProvider.request(.outingSearch(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
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
}
