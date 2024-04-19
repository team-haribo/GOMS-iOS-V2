import Foundation
import Service
import Moya
import UIKit

final class ProfileViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var isDataLoaded = false
    @Published var profileInfo: ProfileResponse?
    
    let provider = MoyaProvider<ProfileServices>(plugins: [NetworkLoggerPlugin()])
    let providerserve = MoyaProvider<ProfileImageServices>(plugins: [NetworkLoggerPlugin()])
    let providerthree = MoyaProvider<LogoutServices>(plugins: [NetworkLoggerPlugin()])
    let token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJhY2Nlc3MiLCJhdXRob3JpdHkiOiJST0xFX1NUVURFTlRfQ09VTkNJTCIsImlhdCI6MTcxMzQ1Mzc3MCwiZXhwIjoxNzEzNDY0NTcwfQ.FgLrHa0xQ3PZZQjP_J6VWwiTaTH4e5cpeQS5vuf4xQU"
    let refreshToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJyZWZyZXNoIiwiaWF0IjoxNzEzNDg5MTAzLCJleHAiOjE3MTE3ODYxMzZ9.uxYQVbVPQ353xPRh0CTOq3DwMxtaXqrXz74mShrOMVU"
    
    // Load profile info
    func loadProfileInfo() {
        provider.request(.getProfile(authorization: token)) { result in
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
    
    // Submit profile image
    func submitProfileImage(imageData: Data) {
        providerserve.request(.submit(authorization: token, imageData: imageData)) { result in
            switch result {
            case .success:
                // Handle success
                print("Profile image submitted successfully")
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }
    
    // Update profile image
    func updateProfileImage(imageData: Data) {
        providerserve.request(.update(authorization: token, imageData: imageData)) { result in
            switch result {
            case .success:
                // Handle success
                print("Profile image updated successfully")
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }
    
    // Delete profile image
    func deleteProfileImage() {
        providerserve.request(.delete(authorization: token)) { result in
            switch result {
            case .success:
                // Handle success
                print("Profile image deleted successfully")
            case let .failure(err):
                self.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }
    
//    func ProfileLogout(presentingViewController: UIViewController) {
//        providerthree.request(.logoutToken(refreshToken: refreshToken)) { [weak self] result in
//            switch result {
//            case .success:
//                // Handle success
//                print("Logout successfully")
//
//                DispatchQueue.main.async {
//                    let newViewController = SignInViewController()
//                    let navigationController = UINavigationController(rootViewController: newViewController)
//                    
//                    // Find the root view controller of the window
//                    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
//                        // Present the navigation controller from the root view controller
//                        rootViewController.present(navigationController, animated: true, completion: nil)
//                    }
//                }
//
//            case let .failure(err):
//                self?.errorMessage = "Network request failed: \(err.localizedDescription)"
//                print("Network request failed: \(err)")
//            }
//        }
//    }
    func ProfileLogout(presentingViewController: UIViewController) {
        providerthree.request(.logoutToken(refreshToken: refreshToken)) { [weak self] result in
            switch result {
            case .success:
                // Handle success
                print("Logout successfully")

                DispatchQueue.main.async {
                    let newViewController = SignInViewController()
                    
                    // Set the new view controller as the root view controller
                    UIApplication.shared.windows.first?.rootViewController = newViewController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }

            case let .failure(err):
                self?.errorMessage = "Network request failed: \(err.localizedDescription)"
                print("Network request failed: \(err)")
            }
        }
    }





}
