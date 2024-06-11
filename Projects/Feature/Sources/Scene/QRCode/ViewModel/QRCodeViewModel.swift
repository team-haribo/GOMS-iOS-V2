import Foundation
import UIKit
import Moya
import Service
import CoreImage.CIFilterBuiltins

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
    
    func makeQR(completion: @escaping (UIImage?) -> Void) {
        studentCouncilProvider.request(.makeQRCode(authorization: accessToken)) { response  in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    do {
                        let responseJSON = try result.mapJSON() as? [String: Any]
                        if let outingUUIDString = responseJSON?["outingUUID"] as? String,
                           let outingUUID = UUID(uuidString: outingUUIDString) {
                            self.outingUUID = outingUUID
                            print("outingUUID 저장 완료")
                        } else {
                            print("outingUUID를 가져올 수 없습니다.")
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
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
                completion(nil)
            }
        }
    }
}
