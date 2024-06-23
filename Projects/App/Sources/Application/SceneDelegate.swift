import UIKit
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var profileModel = ProfileViewModel()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let defaults = UserDefaults.standard
        
        let isSwitchOn = defaults.bool(forKey: "isSwitchOn")
        let adminIsSwitchOn = defaults.bool(forKey: "isSwitchMakeOn")
        
        applySavedTheme()
        
        if let accessToken = KeyChain.shared.read(key: Const.KeyChainKey.accessToken), !accessToken.isEmpty {
            self.profileModel.loadProfileInfo { success in
                if success {
                    let authority = self.profileModel.profileInfo?.authority
                    DispatchQueue.main.async {
                        if authority == "ROLE_STUDENT_COUNCIL" {
                            if adminIsSwitchOn == true {
                                self.window?.rootViewController = UINavigationController(rootViewController: AdminQRCodeViewController()
                            } else {
                                self.window?.rootViewController = UINavigationController(rootViewController: AdminMainViewController())
                            }
                        } else if authority == "ROLE_STUDENT" {
                            if isSwitchOn {
                                self.window?.rootViewController = UINavigationController(rootViewController: QRCodeViewController()
                            } else {
                                self.window?.rootViewController = UINavigationController(rootViewController: MainViewController()
                            }
                        } else {
                            self.window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
                        }
                    }
                } else {
                    self.window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
                }
            }
        } else {
            window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
        }
        
        self.window?.makeKeyAndVisible()
        
        // 네트워크 요청 지연 처리
        DispatchQueue.global().async {
            self.checkForUpdates { [weak self] isUpdateAvailable in
                if isUpdateAvailable {
                    DispatchQueue.main.async {
                        self?.showUpdatePopup()
                        print("업데이트 필요")
                    }
                }
            }
        }
    }
    
    private func applySavedTheme() {
        let savedThemeValue = UserDefaults.standard.integer(forKey: "selectedTheme")
        let savedTheme = UIUserInterfaceStyle(rawValue: savedThemeValue) ?? .unspecified
        window?.overrideUserInterfaceStyle = savedTheme
        
        if let rootViewController = window?.rootViewController as? UserProfileViewController {
            rootViewController.updateThemeText()
        }
    }
    
    private func checkForUpdates(completion: @escaping (Bool) -> Void) {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            completion(false)
            return
        }
        
        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleID)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let appStoreVersion = results.first?["version"] as? String {
                    
                    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    if let currentVersion = currentVersion, currentVersion.compare(appStoreVersion, options: .numeric) == .orderedAscending {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            } catch {
                completion(false)
            }
        }
        task.resume()
    }
    
    private func showUpdatePopup() {
        let alertController = UIAlertController(
            title: "업데이트 알림",
            message: "더 나은 서비스를 위해 곰스가 수정되었어요!\n업데이트해 주시겠어요?",
            preferredStyle: .alert
        )
        
        let updateAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let url = URL(string: "https://apps.apple.com/kr/app/goms/id6502936560") {
                UIApplication.shared.open(url)
            }
        }
        
        alertController.addAction(updateAction)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.window?.rootViewController?.present(alertController, animated: true) {
                print("업데이트 팝업 표시됨")
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
