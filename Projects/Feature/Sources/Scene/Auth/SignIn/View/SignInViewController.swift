//
//  SignInViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class SignInViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel = SignInViewModel()
    
    private lazy var textFieldStackView = UIStackView().then {
        $0.spacing = 24
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let emailTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "이메일")
    
    private let defaultDomain = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    private let findPasswordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 48)).then {
        $0.text = "비밀번호를 잊으셨나요?"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    private lazy var findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var authenticationNumberButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증번호 받기").then {
        $0.addTarget(self, action: #selector(authenticationNumberButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Seletors
    @objc func findPasswordButtonTapped() {
        let findPasswordVC = ResetPasswordAuthViewController()
        navigationController?.pushViewController(findPasswordVC, animated: true)
    }
    
    @objc func authenticationNumberButtonTapped() {
//        let authNumberVC = AuthNumberViewController()
//        navigationController?.pushViewController(authNumberVC, animated: true)
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        textFieldStackView.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.23)
        }
        
        authenticationNumberButton.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.41)
        }
    }

    @objc override func keyboardWillHide(_ sender: Notification) {
        textFieldStackView.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.35)
        }
        
        authenticationNumberButton.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
        }
    }
    
    // MARK: - Navigaiton
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "로그인"
    }
    
    // MARK: - Add View
    override func addView() {
        emailTextField.addSubview(defaultDomain)
        [emailTextField, passwordTextField].forEach { textFieldStackView.addArrangedSubview($0) }
        [textFieldStackView, findPasswordLabel, findPasswordButton, authenticationNumberButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        defaultDomain.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.35)
        }
        
        findPasswordLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.trailing.equalTo(-bounds.width * 0.07)
            $0.top.equalTo(passwordTextField.snp.bottom)
        }
        
        authenticationNumberButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.text != "", passwordTextField.text != "" {
            passwordTextField.resignFirstResponder()
            return true
        } else if emailTextField.text != "" {
            passwordTextField.becomeFirstResponder()
            return true
        }
        return false
    }
}

