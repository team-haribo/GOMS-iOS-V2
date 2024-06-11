import Foundation
import Service
import Moya
import Combine
import UIKit

final class ProfileViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var isDataLoaded = false
    @Published var profileInfo: ProfileResponse?

    let provider = MoyaProvider<ProfileServices>(plugins: [NetworkLoggerPlugin()])
    let providerserve = MoyaProvider<AccountServices>(plugins: [NetworkLoggerPlugin()])
    let providerthree = MoyaProvider<AuthServices>(plugins: [NetworkLoggerPlugin()])
    let keyChain = KeyChain()
    lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")
    private lazy var refreshToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.refreshToken) ?? "")

    private var password: String = ""
    private var rePassword: String = ""

    func setupPassword(password: String) {
        self.password = password
    }

    func setupRePassword(rePassword: String) {
        self.rePassword = rePassword
    }

    func loadProfileInfo(completion: @escaping (Bool) -> Void) {
        provider.request(.getProfile(authorization: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    let profileModel = try decoder.decode(ProfileResponse.self, from: response.data)
                    self.profileInfo = profileModel
                    self.isDataLoaded = true
                    completion(true) // 호출 성공 시 true 반환
                } catch {
                    self.errorMessage = "Failed to decode JSON response"
                    completion(false) // 호출 실패 시 false 반환
                }
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
                completion(false) // 호출 실패 시 false 반환
            }
        }
    }


    func submitProfileImage(imageData: Data) -> Future<Void, Error> {
        Future { promise in
            self.provider.request(.submit(authorization: self.accessToken, imageData: imageData)) { result in
                switch result {
                case .success:
                    promise(.success(()))
                case let .failure(err):
                    promise(.failure(err))
                }
            }
        }
    }

    func updateProfileImage(imageData: Data) -> Future<Void, Error> {
        Future { promise in
            self.provider.request(.update(authorization: self.accessToken, imageData: imageData)) { result in
                switch result {
                case .success:
                    promise(.success(()))
                case let .failure(err):
                    promise(.failure(err))
                }
            }
        }
    }

    func deleteProfileImage() -> Future<Void, Error> {
        Future { promise in
            self.provider.request(.delete(authorization: self.accessToken)) { result in
                switch result {
                case .success:
                    promise(.success(()))
                case let .failure(err):
                    promise(.failure(err))
                }
            }
        }
    }

    func ProfileLogout(presentingViewController: UIViewController) {
        providerthree.request(.logoutToken(refreshToken: refreshToken)) { [weak self] result in
            switch result {
            case .success:
                print("Logout successfully")

            case let .failure(err):
                self?.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }
    
    func withdraw(completion: @escaping (Bool) -> Void) {
        providerserve.request(.withdraw(password: self.password, authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 205:
                    print(result.data)
                    completion(true)
                case 404:
                    print(result.data)
                    completion(false)
                    print("응 오류ㅋㅋㅋㅋㅋㅋㅋ")
                case 400:
                    print("현재 비밀번호 입력 String: \(self.password)")
                    print(result.data)
                    completion(false)
                    print("응 오류ㅋㅋㅋ")
                default:
                    print(result)
                    completion(false)
                    print("응 오류ㅋㅋㅋㅋ")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
                print("응 오류ㅋㅋㅋㅋㅋ")
            }
        }
    }
}
