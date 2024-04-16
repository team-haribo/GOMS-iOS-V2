import Foundation
import UIKit
import Moya
import Service

public final class QRCodeViewModel {
    private let qrCodeProvider = MoyaProvider<StudentCouncilServices>()
    
    public var outingUUID = UUID()
    
    public func QRCode(completion: @escaping (Bool) -> Void) {
        let param = QRCodeRequest(outingUUID: outingUUID)
        let outingUUIDString = param.outingUUID.uuidString
        let queryParameters: [String: Any] = ["outingUUID": outingUUIDString]
        let queryString = queryParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        
        qrCodeProvider.request(.makeQRCode(authorization: queryString)) { response in
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
