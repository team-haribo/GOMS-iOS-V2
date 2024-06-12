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
    let viewModel = BaseViewModel()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let defaults = UserDefaults.standard
        
        let isSwitchOn = defaults.bool(forKey: "isSwitchOn")
        let AdminisSwitchOn = defaults.bool(forKey: "AdminisSwitchOn")
        
        applySavedTheme()
        
        let authority = UserDefaults.standard.string(forKey: "authority")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            if self.viewModel.isLogin == true {
                if AdminisSwitchOn == true {
                    if isSwitchOn == true {
                        self.window?.rootViewController = UINavigationController(rootViewController: AdminQRCodeViewController())
                    } else {
                        self.window?.rootViewController = UINavigationController(rootViewController: AdminMainViewController())
                    }
                } else if AdminisSwitchOn == false {
                    if isSwitchOn == true {
                        self.window?.rootViewController = UINavigationController(rootViewController: QRCodeViewController())
                    } else {
                        self.window?.rootViewController = UINavigationController(rootViewController: MainViewController())
                    }
                }
            } else {
                self.window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
            }
        }

        window?.makeKeyAndVisible()
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

