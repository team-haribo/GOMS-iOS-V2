//
//  LetecomerViewModel.swift
//  Feature
//
//  Created by 새미 on 4/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Moya
import Service

struct LatecomerListData {
    let id: UUID
    let profileImageURL: String?
    let name: String
    let grade: Int
    let major: String
}

public final class LetecomerViewModel: BaseViewModel {
    
    private let studentCouncilProvider = MoyaProvider<StudentCouncilServices>()
    
    var date: String = ""
    
    var latecomerList: [LatecomerListResponse] = []
    var latecomerListDatas: [LatecomerListData] = []
    
    func setupDate(date: String) {
        self.date = date
    }
    
    func getLatecomerList(completion: @escaping () -> Void) {
        studentCouncilProvider.request(.lateList(authorization: accessToken, date: date)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                do {
                    self.latecomerList = try JSONDecoder().decode([LatecomerListResponse].self, from: responseData)
                    self.latecomerListDatas = self.latecomerList.map { LatecomerListData(id: $0.accountIdx, profileImageURL: $0.profileUrl, name: $0.name, grade: $0.grade, major: $0.major) }
                    completion()
                } catch(let err) {
                    print(String(describing: err))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
