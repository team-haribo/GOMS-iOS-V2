//
//  NotificationViewModel.swift
//  Feature
//
//  Created by 서지완 on 12/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation
import Service
import Moya

public final class NotificationViewModel: ObservableObject {
    @Published public var notificationModel: NotificationModel?

    public init() {}

    public let providerNotification = MoyaProvider<NotificationServices>(plugins: [NetworkLoggerPlugin()])

    public func getOutingStatus(completion: @escaping (Result<Bool, Error>) -> Void) {
        providerNotification.request(.getOuting) { result in
            switch result {
            case let .success(response):
                do {
                    let notificationModel = try response.map(NotificationModel.self)
                    self.notificationModel = notificationModel
                    print(notificationModel.data.outingStatus)
                    completion(.success(notificationModel.data.outingStatus))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
