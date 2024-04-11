//
//  FindPasswordViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class ResetPasswordAuthViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel = SignUpViewModel()
    
    private let emailTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "이메일")
    
    private let defaultDomain = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let authButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증번호 받기")
    
    // MARK:  - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
    }
    
    // MARK: - Selectors
    @objc func authButtonTapped() {
        viewModel.sendAuthNumber { success in
            if success {
                let authNumberVC = AuthNumberViewController(viewModel: self.viewModel)
                self.navigationController?.pushViewController(authNumberVC, animated: true)
            }
        }
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        emailTextField.snp.remakeConstraints {
            $0.top.equalTo(bounds.height * 0.31)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(64)
        }
        
        authButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(48)
            $0.bottom.equalTo(-bounds.height * 0.41)
        }
    }

    @objc override func keyboardWillHide(_ sender: Notification) {
        emailTextField.snp.remakeConstraints{
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(64)
            $0.top.equalTo(bounds.height * 0.43)
        }
        
        authButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(48)
            $0.bottom.equalTo(-bounds.height * 0.16)
        }
    }
    
    // MARK: - Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "비밀번호 재설정"
    }
    
    // MARK: - Add View
    override func addView() {
        emailTextField.addSubview(defaultDomain)
        [emailTextField, authButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        defaultDomain.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(64)
            $0.top.equalTo(bounds.height * 0.43)
        }
        
        authButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(48)
            $0.bottom.equalTo(-bounds.height * 0.16)
        }
    }
}

extension ResetPasswordAuthViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            viewModel.setupEmail(email: textField.text ?? "")
        }
    }
}
