import Foundation
import Service
import Moya
import UIKit

final class ProfileViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var isDataLoaded = false
    @Published var profileInfo: ProfileResponse?
    
    let provider = MoyaProvider<ProfileServices>(plugins: [NetworkLoggerPlugin()])
    let providerthree = MoyaProvider<AuthServices>(plugins: [NetworkLoggerPlugin()])
    let keyChain = KeyChain()
    lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")
    private lazy var refreshToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.refreshToken) ?? "")
    
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
    
    func submitProfileImage(imageData: Data) {
        provider.request(.submit(authorization: accessToken, imageData: imageData)) { result in
            switch result {
            case .success:
                print("Profile image submitted successfully")
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }
    
    func updateProfileImage(imageData: Data) {
        provider.request(.update(authorization: accessToken, imageData: imageData)) { result in
            switch result {
            case .success:
                print("Profile image updated successfully")
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }
    
    func deleteProfileImage() {
        provider.request(.delete(authorization: accessToken)) { result in
            switch result {
            case .success:
                print("Profile image deleted successfully")
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }
    
    func ProfileLogout(presentingViewController: UIViewController) {
<<<<<<< HEAD:Projects/App/Sources/Application/ProfileViewModel.swift
        providerthree.request(.logoutToken(refreshToken: refreshToken)) { [weak self] result in
            switch result {
            case .success:
                print("Logout successfully")

                DispatchQueue.main.async {
                    let newViewController = SignInViewController()
                    UIApplication.shared.windows.first?.rootViewController = newViewController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }

            case let .failure(err):
                self?.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
=======
//        providerthree.request(.logoutToken(refreshToken: gomsRefreshToken)) { [weak self] result in
//            switch result {
//            case .success:
//                print("Logout successfully")
//
//                DispatchQueue.main.async {
//                    let newViewController = SignInViewController()
//                    UIApplication.shared.windows.first?.rootViewController = newViewController
//                    UIApplication.shared.windows.first?.makeKeyAndVisible()
//                }
//
//            case let .failure(err):
//                self?.errorMessage = "Network request failed: \(err.localizedDescription)"
//                print("Network request failed: \(err)")
//            }
//        }
>>>>>>> d768939 (✨ :: Delete Outing Student Service):Projects/Feature/Sources/Scene/Profile/ViewModel/ProfileViewModel.swift
    }
}
