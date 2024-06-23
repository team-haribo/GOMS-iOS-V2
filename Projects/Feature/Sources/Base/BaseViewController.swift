//
//  BaseViewController.swift
//  Feature
//
//  Created by 새미 on 1/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class BaseViewController: UIViewController {
    
    // MARK: - Properties
    let bounds = UIScreen.main.bounds
    
    // MARK: - Life Cycel
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.setDynamicBackgroundColor(
            darkModeColor: .color.gomsBackground.color,
            lightModeColor: .color.gomsLightBackground.color
        )
        configNavigation()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    
        setupKeyboardEvent()
        configureUI()
        addView()
        setLayout()
    }
    
    // MARK: - Keyboard
    @objc func keyboardWillShow(_ sender: Notification) { }
    
    @objc func keyboardWillHide(_ sender: Notification) { }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - Configure Navigaiton
    func configNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        self.navigationController?.navigationBar.clipsToBounds = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Layout
    func configureUI() {}
    func addView() {}
    func setLayout() {}
}
