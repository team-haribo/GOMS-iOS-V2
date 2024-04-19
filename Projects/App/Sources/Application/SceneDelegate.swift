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
            defaults.register(defaults: ["isSwitchOn": false])
            print(isSwitchOn)
            
            if isSwitchOn == true {
                DispatchQueue.main.async {
                    let newViewController = QRCodeViewController()
                    
                    // Set the new view controller as the root view controller
                    UIApplication.shared.windows.first?.rootViewController = newViewController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            } else {
                DispatchQueue.main.async {
                    let newViewController = UserProfileViewController()
                    
                    // Set the new view controller as the root view controller
                    UIApplication.shared.windows.first?.rootViewController = newViewController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}


