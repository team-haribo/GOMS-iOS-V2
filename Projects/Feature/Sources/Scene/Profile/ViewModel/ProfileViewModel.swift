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

    func loadProfileInfo() {
        provider.request(.getProfile(authorization: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    let profileModel = try decoder.decode(ProfileResponse.self, from: response.data)
                    self.profileInfo = profileModel
                    self.isDataLoaded = true
                } catch {
                    self.errorMessage = "Failed to decode JSON response"
                }

            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
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
}
