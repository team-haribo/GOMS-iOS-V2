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
    let token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJhY2Nlc3MiLCJhdXRob3JpdHkiOiJST0xFX1NUVURFTlRfQ09VTkNJTCIsImlhdCI6MTcxMzUyNDc5NywiZXhwIjoxNzEzNTM1NTk3fQ.rqoP4RA97w2_cbvi7Ur9kuMuAlcKg7FJUeNQOEsHRko"
    let refreshToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJyZWZyZXNoIiwiaWF0IjoxNzEzNTI0Nzk3LCJleHAiOjE3MTE4MjE4Mjl9.IBZdoIZAU1pLiCO5brvznZ8OvDlLgqL4gmBOYTTiW0k"
    
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
    
    func ProfileLogout(presentingViewController: UIViewController) {
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
    }





}
