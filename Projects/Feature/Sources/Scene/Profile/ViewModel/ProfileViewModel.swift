import Foundation
import Service
import Moya
import Combine
import UIKit

public final class ProfileViewModel: ObservableObject {
    @Published public var errorMessage = ""
    @Published public var isDataLoaded = false
    @Published public var profileInfo: ProfileResponse?
    
    public init() {}

    public let providerProfile = MoyaProvider<ProfileServices>(plugins: [NetworkLoggerPlugin()])
    let providerserve = MoyaProvider<AccountServices>(plugins: [NetworkLoggerPlugin()])
    let providerthree = MoyaProvider<AuthServices>(plugins: [NetworkLoggerPlugin()])
    let keyChain = KeyChain()
    public lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")
    private lazy var refreshToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.refreshToken) ?? "")

    private var password: String = ""
    private var rePassword: String = ""

    public func setupPassword(password: String) {
        self.password = password
    }

    public func setupRePassword(rePassword: String) {
        self.rePassword = rePassword
    }

    public func loadProfileInfo(completion: @escaping (Bool) -> Void) {
        providerProfile.request(.getProfile(authorization: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    let profileModel = try decoder.decode(ProfileResponse.self, from: response.data)
                    self.profileInfo = profileModel
                    self.isDataLoaded = true
                    completion(true)
                } catch {
                    self.errorMessage = "Failed to decode JSON response"
                    completion(false)
                }
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
                completion(false)
            }
        }
    }
    
    func submitProfileImage(imageData: Data) -> Future<Void, Error> {
        Future { promise in
            self.providerProfile.request(.submit(authorization: self.accessToken, imageData: imageData)) { result in
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
            self.providerProfile.request(.update(authorization: self.accessToken, imageData: imageData)) { result in
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
            self.providerProfile.request(.delete(authorization: self.accessToken)) { result in
                switch result {
                case .success:
                    promise(.success(()))
                case let .failure(err):
                    promise(.failure(err))
                }
            }
        }
    }

    func profileLogout(completion: @escaping (Bool) -> Void) {
        providerthree.request(.logoutToken(refreshToken: refreshToken)) { [weak self] result in
            switch result {
            case .success:
                self?.keyChain.delete(key: Const.KeyChainKey.accessToken)
                print("Logout successfully")

            case let .failure(err):
                self?.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
        completion(true)
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
                case 400:
                    print("현재 비밀번호 입력 String: \(self.password)")
                    print(result.data)
                    completion(false)
                default:
                    print(result)
                    completion(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
}
