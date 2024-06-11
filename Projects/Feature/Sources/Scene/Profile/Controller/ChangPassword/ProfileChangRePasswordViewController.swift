//
//  ProfileChangRePasswordViewController.swift
//  Feature
//
//  Created by 서지완 on 4/25/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import Combine
import Moya
import SnapKit
import Service

public class ProfileChangRePasswordViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let viewModel = ProfileViewModel()
    
    let navigationTitle = UILabel().then {
        $0.text = "비밀번호 재설정"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 29, weight: .bold)
    }
    
    let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "현재 비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    lazy var visiblePasswordButton = UIButton().then {
        $0.setImage(.image.visible.image, for: .normal)
        $0.addTarget(self, action: #selector(visiblePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var doneButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "다음으로").then {
        $0.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    private var doneButtonBottomConstraint: Constraint?
    private var textFieldBottomConstraint: Constraint?
    
    @objc func doneButtonTapped() {
        let defaults = UserDefaults.standard
        let localPassword = defaults.string(forKey: "localPassword")
        if localPassword == passwordTextField.text {
            let newPasswordVC = ChangNewPasswordViewController()
            navigationController?.pushViewController(newPasswordVC, animated: true)
        } else {
            print("비밀번호가 틀렸습니다.")
        }
    }
    
    @objc func visiblePasswordButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.isSelected.toggle()
        
        if passwordTextField.isSelected {
            visiblePasswordButton.setImage(.image.invisible.image, for: .normal)
        } else {
            visiblePasswordButton.setImage(.image.visible.image, for: .normal)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func addView() {
        passwordTextField.addSubview(visiblePasswordButton)
        
        [
            navigationTitle,
            passwordTextField,
            doneButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        navigationTitle.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(183)
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(bounds.width * 0.05)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.width.equalTo(335)
            $0.bottom.equalTo(navigationTitle.snp.bottom).offset(90)
            $0.leading.equalToSuperview().inset(bounds.width * 0.05)
            $0.trailing.equalToSuperview().inset(bounds.width * 0.05)
        }
        
        visiblePasswordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints {
            doneButtonBottomConstraint = $0.bottom.equalToSuperview().inset(bounds.height * 0.19).constraint
            $0.height.equalTo(48)
            $0.width.equalTo(335)
            $0.leading.equalToSuperview().inset(bounds.width * 0.05)
            $0.trailing.equalToSuperview().inset(bounds.width * 0.05)
        }
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.doneButtonBottomConstraint?.update(inset: keyboardHeight + 13)
            self.textFieldBottomConstraint?.update(inset: keyboardHeight + (self.bounds.height * 0.2))
            
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.doneButtonBottomConstraint?.update(inset: self.bounds.height * 0.19)
            self.textFieldBottomConstraint?.update(inset: self.bounds.height * 0.45)
            
            self.view.layoutIfNeeded()
        }
    }
}
