import Foundation
import UIKit
import Moya
import Service

public final class QRCodeViewModel: BaseViewModel {
    private let studentCouncilProvider = MoyaProvider<StudentCouncilServices>()
    private let outingProvider = MoyaProvider<OutingServices>()
    
    public var outingUUID = UUID()
    
    func outing(completion: @escaping (Bool) -> Void) {
        outingProvider.request(.outing(outingUUID: outingUUID, authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 201:
                    print("Created")
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 403:
                    print("학생회 계정이 아닌데 요청할 경우")
                case 404:
                    print("계정을 찾을 수 없을 경우")
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
    
    func makeQR(completion: @escaping (Bool) -> Void) {
        studentCouncilProvider.request(.makeQRCode(authorization: accessToken)) { response  in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("생성")
                case 401:
                    self.gomsRefreshToken.tokenReissuance()
                case 403:
                    print("학생회 계정이 아닌데 요청할 경우")
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

    
    public func QRCode(completion: @escaping (Bool) -> Void) {
        let param = QRCodeRequest(outingUUID: outingUUID)
        let outingUUIDString = param.outingUUID.uuidString
        let queryParameters: [String: Any] = ["outingUUID": outingUUIDString]
        let queryString = queryParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        
        studentCouncilProvider.request(.makeQRCode(authorization: queryString)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("OK")
                    completion(true)
                case 500:
                    print("SERVER ERROR")
                    completion(false)
                default:
                    print(result)
                    completion(false)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
