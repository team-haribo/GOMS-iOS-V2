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
                    print("카메라켜기 \(isSwitchOn)")
                    print("QR켜기 \(adminIsSwitchOn)")
                    let authority = self.profileModel.profileInfo?.authority
                    DispatchQueue.main.async {
                        if authority == "ROLE_STUDENT_COUNCIL" {
                            if adminIsSwitchOn == true {
                                self.window?.rootViewController =  UINavigationController(rootViewController: AdminQRCodeViewController())
                                print("qr생성켜짐")
                            } else {
                                self.window?.rootViewController =  UINavigationController(rootViewController: AdminMainViewController())
                                print("그냥 어드민뷰")
                            }
                        } else if authority == "ROLE_STUDENT" {
                            if isSwitchOn {
                                self.window?.rootViewController =  UINavigationController(rootViewController: QRCodeViewController())
                                print("카메라켜짐")
                            } else {
                                self.window?.rootViewController =  UINavigationController(rootViewController: MainViewController())
                                print("그냥 메인뷰")
                            }
                        } else {
                            self.window?.rootViewController =  UINavigationController(rootViewController: IntroViewController())
                        }
                    }
                } else {
                    self.window?.rootViewController =  UINavigationController(rootViewController: IntroViewController())
                }
            }
        } else {
            window?.rootViewController =  UINavigationController(rootViewController: IntroViewController())
        }
        self.window?.makeKeyAndVisible()
    }
    

//        if isSwitchOn == true {
//            self.window?.rootViewController =  UINavigationController(rootViewController: QRCodeViewController())
//        } else if adminIsSwitchOn == true {
//            self.window?.rootViewController =  UINavigationController(rootViewController: AdminQRCodeViewController())
//        } else {
//            self.window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
//        }

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

