import Foundation
import UIKit
import Moya
import Service
import CoreImage.CIFilterBuiltins

public final class QRCodeViewModel: BaseViewModel {
    private let studentCouncilProvider = MoyaProvider<StudentCouncilServices>()
    private let outingProvider = MoyaProvider<OutingServices>()
    private let profileViewModel = ProfileViewModel()
    
    public var outingUUID: UUID = UUID()
    private var isRequesting: Bool = false

    func outing(completion: @escaping (Int) -> Void) {
        guard !isRequesting else {
            print("이미 외출 요청이 진행 중입니다.")
            return
        }
        
        isRequesting = true
        outingProvider.request(.outing(outingUUID: outingUUID, authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 204:
                    print("Created")
                    completion(statusCode)
                case 400:
                    print("나갈려는 학생이 블랙리스트인 경우")
                    print("검증 안된 outingUUID인 경우")
                    print("outingUUID를 보내지 않은 경우")
                    self.profileViewModel.loadProfileInfo { success in
                        if success {
                            if let profileInfo = self.profileViewModel.profileInfo {
                                print("Profile name: \(profileInfo.name)")
                                print("Profile blackList: \(profileInfo.isBlackList)")
                                if profileInfo.isBlackList == true {
                                    completion(400)
                                    print("4000000")
                                } else {
                                    completion(405)
                                 }
                            } else {
                                print("Profile info is nil")
                            }
                        } else {
                            print("Failed to load profile info")
                        }
                    }
                case 401:
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
    
    func makeQR(completion: @escaping (Bool) -> Void) {
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
                            completion(true)
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
                    completion(false)
                case 500:
                    print("SERVER ERROR")
                    completion(false)
                default:
                    print(result)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
}

