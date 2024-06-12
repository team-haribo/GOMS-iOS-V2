//
//  AppDelegate.swift
//  GOMS-iOS-V2
//
//  Created by 새미 on 1/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import Feature

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
       let viewModel = AuthViewModel()

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
           if UserDefaults.standard.bool(forKey: "isAutoLoginEnabled") {
               print("Auto login enabled")
               
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
                                       print("No authority.")
                                       self.presentToLogin()
                                   }
                               }
                           } else {
                               print("Failed to load profile information")
                               self.presentToLogin()
                           }
                       }
                   } else {
                       print("Auto login failed.")
                       self.presentToLogin()
                   }
               }
           } else {
               print("Auto login is disabled.")
               presentToLogin()
           }
           
           return true
       }

       private func presentToLogin() {
           let introVC = IntroViewController()
           window?.rootViewController = UINavigationController(rootViewController: introVC)
       }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}
