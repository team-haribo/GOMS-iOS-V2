//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by 새미 on 1/10/24.
//

import UIKit
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let viewModel = AuthViewModel()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "isAutoLoginEnabled") {
            let accessToken = viewModel.accessToken
            
            viewModel.signInWithToken(accessToken: accessToken) { success in
                if success {
                    self.viewModel.profileModel.loadProfileInfo { profileSuccess in
                        if profileSuccess {
                            DispatchQueue.main.async {
                                let authority = self.viewModel.profileModel.profileInfo?.authority
                                if authority == "ROLE_STUDENT_COUNCIL" {
                                    let mainVC = AdminMainViewController()
                                    self.window?.rootViewController = UINavigationController(rootViewController: mainVC)
                                } else if authority == "ROLE_STUDENT" {
                                    let mainVC = MainViewController()
                                    self.window?.rootViewController = UINavigationController(rootViewController: mainVC)
                                } else {
                                    print("권한이 없습니다.")
                                    self.presentToLogin()
                                }
                            }
                        } else {
                            print("프로필 정보 가져오기 실패")
                            self.presentToLogin()
                        }
                    }
                } else {
                    print("자동 로그인 실패.")
                    self.presentToLogin()
                }
            }
        } else {
            print("저장된 토큰이 없습니다.")
            presentToLogin()
        }
        
        window?.makeKeyAndVisible()
    }

    private func presentToLogin() {
        let introVC = IntroViewController()
        window?.rootViewController = UINavigationController(rootViewController: introVC)
    }
    
    private func applySavedTheme() {
        let savedThemeValue = UserDefaults.standard.integer(forKey: "selectedTheme")
        let savedTheme = UIUserInterfaceStyle(rawValue: savedThemeValue) ?? .unspecified
        window?.overrideUserInterfaceStyle = savedTheme
        
        if let rootViewController = window?.rootViewController as? UserProfileViewController {
            rootViewController.updateThemeText()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

