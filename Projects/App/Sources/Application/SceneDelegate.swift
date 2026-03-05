import UIKit
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let refreshTokenManager = GOMSRefreshToken.shared
    public let notificationViewModel = NotificationViewModel()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let defaults = UserDefaults.standard
        let isSwitchOn = defaults.bool(forKey: "isSwitchOn")
        let adminIsSwitchOn = defaults.bool(forKey: "isSwitchMakeOn")

        //*checkForUpdates { needsUpdate in
         //   if needsUpdate {
        //        print("업데이트 필요")
        //        self.showUpdatePopup()
        //    } else {
         //       print("최신 버전입니다")
          //  }
       // }

        applySavedTheme()

        if let accessToken = KeyChain.shared.read(key: Const.KeyChainKey.accessToken), !accessToken.isEmpty {
            refreshTokenManager.tokenReissuance { [weak self] success in
                guard let self = self else { return }
                if success {
                    if let savedToken = UserDefaults.standard.string(forKey: "FCMToken") {
                        notificationViewModel.setupFcmToken(fcmToken: savedToken)
                        notificationViewModel.setupaccessToken(accessToken: accessToken)
                        notificationViewModel.postFcmToken { success in
                            if success {
                                print("FCM 토큰 전송 성공")
                            } else {
                                print("FCM 토큰 전송 실패")
                            }
                        }
                    }
                    self.setRootViewControllerBasedOnAuthority(isSwitchOn: isSwitchOn, adminIsSwitchOn: adminIsSwitchOn)
                } else {
                    self.showLoginScreen()
                }
            }
        } else {
            showLoginScreen()
        }

        self.window?.makeKeyAndVisible()
    }

    private func setRootViewControllerBasedOnAuthority(isSwitchOn: Bool, adminIsSwitchOn: Bool) {
        let authority = KeyChain.shared.read(key: Const.KeyChainKey.authority)

        DispatchQueue.main.async {
            if authority == "ROLE_STUDENT_COUNCIL" {
                let adminMainVC = AdminMainViewController()
                let navigationController = UINavigationController(rootViewController: adminMainVC)
                self.window?.rootViewController = navigationController

                if adminIsSwitchOn {
                    print("Admin Screen: AdminMainViewController with AdminQRViewController")
                    let adminQRVC = AdminQRViewController()
                    navigationController.pushViewController(adminQRVC, animated: false)
                } else {
                    print("Admin Screen: AdminMainViewController")
                }
            } else if authority == "ROLE_STUDENT" {
                if isSwitchOn {
                    print("Student Screen: StudentQRViewController")
                    self.window?.rootViewController = UINavigationController(rootViewController: StudentQRViewController())
                } else {
                    print("Student Screen: MainViewController")
                    self.window?.rootViewController = UINavigationController(rootViewController: MainViewController())
                }
            } else {
                self.showLoginScreen()
            }
        }
    }

    private func showLoginScreen() {
        DispatchQueue.main.async {
            self.window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
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
        DispatchQueue.main.async {

            guard let rootVC = self.window?.rootViewController else { return }

            // 이미 다른 VC를 present 중이면 중복 방지
            if rootVC.presentedViewController != nil { return }

            let alertController = UIAlertController(
                title: "업데이트 알림",
                message: "원활한 사용을 위해 업데이트 후 이용해주세요!",
                preferredStyle: .alert
            )

            alertController.addAction(UIAlertAction(title: "업데이트", style: .default) { _ in
                if let url = URL(string: "앱스토어URL") {
                    UIApplication.shared.open(url)
                }
            })

            rootVC.present(alertController, animated: true)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {
        checkForUpdates { needsUpdate in
            if needsUpdate {
                DispatchQueue.main.async {
                    self.showUpdatePopup()
                }
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
