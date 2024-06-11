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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let defaults = UserDefaults.standard
        
        let isSwitchOn = defaults.bool(forKey: "isSwitchOn")
        let AdminisSwitchOn = defaults.bool(forKey: "AdminisSwitchOn")
        print("\(isSwitchOn)|\(AdminisSwitchOn)")
        
        applySavedTheme()
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if isLoggedIn == true {
            let authority = UserDefaults.standard.string(forKey: "authority")
            switch authority {
            case "ROLE_STUDENT_COUNCIL":
                if isSwitchOn == true {
                    window?.rootViewController =  UINavigationController(rootViewController: QRCodeViewController())
                } else if AdminisSwitchOn == true {
                    window?.rootViewController =  UINavigationController(rootViewController: AdminQRCodeViewController())
                } else {
                    window?.rootViewController = UINavigationController(rootViewController: AdminMainViewController())
                }
            case "ROLE_STUDENT":
                if isSwitchOn == true {
                    window?.rootViewController =  UINavigationController(rootViewController: QRCodeViewController())
                } else if AdminisSwitchOn == true {
                    window?.rootViewController =  UINavigationController(rootViewController: AdminQRCodeViewController())
                } else {
                    window?.rootViewController = UINavigationController(rootViewController: MainViewController())
                }
            default:
                window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
            }
        } else {
            window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
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

