import UIKit
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var profileModel = ProfileViewModel()
    private let refreshTokenManager = GOMSRefreshToken.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        applySavedTheme()
        setupRootViewController()
        self.window?.makeKeyAndVisible()
        
        DispatchQueue.global().async {
            self.checkForUpdates { [weak self] isUpdateAvailable in
                if isUpdateAvailable {
                    DispatchQueue.main.async {
                        self?.showUpdatePopup()
                    }
                }
            }
        }
    }
    
    private func setupRootViewController() {
        let defaults = UserDefaults.standard
        let isLoggedIn = defaults.object(forKey: "isLoggedIn") as? Bool ?? false
        let isSwitchOn = defaults.bool(forKey: "isSwitchOn")
        let adminIsSwitchOn = defaults.bool(forKey: "isSwitchMakeOn")
        
        if isLoggedIn {
            if let accessToken = KeyChain.shared.read(key: Const.KeyChainKey.accessToken), !accessToken.isEmpty {
                refreshTokenManager.tokenReissuance()
                let authority = KeyChain.shared.read(key: Const.KeyChainKey.authority)
                
                let rootViewController = determineRootViewController(isLoggedIn: true, isSwitchOn: isSwitchOn, adminIsSwitchOn: adminIsSwitchOn, accessToken: accessToken, authority: authority)
                self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
            } else {
                handleNoAccessToken()
            }
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
        }
    }
    
    private func determineRootViewController(isLoggedIn: Bool, isSwitchOn: Bool, adminIsSwitchOn: Bool, accessToken: String?, authority: String?) -> UIViewController {
        guard let authority = authority else {
            return IntroViewController()
        }
        
        switch authority {
        case "ROLE_STUDENT_COUNCIL":
            return adminIsSwitchOn ? AdminQRCodeViewController() : AdminMainViewController()
        case "ROLE_STUDENT":
            return isSwitchOn ? QRCodeViewController() : MainViewController()
        default:
            return IntroViewController()
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
    
    private func handleNoAccessToken() {
        let defaults = UserDefaults.standard
        let isSwitchOn = defaults.bool(forKey: "isSwitchOn")
        let adminIsSwitchOn = defaults.bool(forKey: "isSwitchMakeOn")
        
        refreshTokenManager.tokenReissuance()
        let authority = KeyChain.shared.read(key: Const.KeyChainKey.authority)
        
        let rootViewController = determineRootViewController(isLoggedIn: false, isSwitchOn: isSwitchOn, adminIsSwitchOn: adminIsSwitchOn, accessToken: nil, authority: authority)
        self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        setupRootViewController()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        refreshTokenManager.tokenReissuance()
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
}
