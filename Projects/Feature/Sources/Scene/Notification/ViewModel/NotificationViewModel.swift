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
    public init() {}

    public let providerNotification = MoyaProvider<NotificationServices>(plugins: [NetworkLoggerPlugin()])

    public func postFcmToken(fcmToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
        providerNotification.request(.postFcmToken(param: NotificationRequest(fcmToken: fcmToken))) { result in
            switch result {
            case .success(_):
                print("SuccessㅣFCM Token 전송")
                completion(.success(()))
            case .failure(let error):
                print("FailureㅣFCM Token 전송 실패")
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
