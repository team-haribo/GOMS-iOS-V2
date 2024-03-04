//
//  OutingStatusViewModel.swift
//  Feature
//
//  Created by 새미 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Moya
import Service

protocol OutingStatusViewModelDelegate: AnyObject {
    func outingListDidUpdate()
    func handleError(_ error: Error)
}

class OutingStatusViewModel {
    weak var delegate: OutingStatusViewModelDelegate?
    
    private let outingService: MoyaProvider<OutingServices>
    private var outingList: [OutingListResponse] = []
    
    init(outingService: MoyaProvider<OutingServices>) {
        self.outingService = outingService
    }
    
    func fetchOutingList(authorization: String) {
        outingService.request(.outingList(authorization: authorization)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let outingListModel = try response.map(OutingListModel.self)
                    self?.outingList = [outingListModel.data] // 받아온 데이터를 outingList에 할당
                    self?.delegate?.outingListDidUpdate()
                } catch {
                    self?.delegate?.handleError(error)
                }
            case .failure(let error):
                self?.delegate?.handleError(error)
            }
        }
    }
    
    func numberOfOutingList() -> Int {
        return outingList.count
    }
    
    func outing(at index: Int) -> OutingListResponse? {
        guard index >= 0 && index < outingList.count else { return nil }
        return outingList[index]
    }
}

