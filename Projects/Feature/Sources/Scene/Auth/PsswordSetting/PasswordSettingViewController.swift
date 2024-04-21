//
//  PasswordSettingViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class PasswordSettingViewController: BaseViewController {

    // MARK: - Properties
    private var viewModel = AuthViewModel()
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let textFieldStackView = UIStackView().then {
        $0.spacing = 32
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    private let checkPasswordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호 확인").then {
        $0.isSecureTextEntry = true
    }
    
    private let conditionsLabel = UILabel().then {
        $0.text = "대/소문자, 특수문자 포함 12자 이상"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private lazy var signUpButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "회원가입").then {
        $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
    }
    
    // MARK: - Seletors
    @objc func signUpButtonTapped() {
        viewModel.SignUp { success in
            if success {
                let signInVC = SignInViewController()
                self.navigationController?.pushViewController(signInVC, animated: true)
            }
        }
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        textFieldStackView.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.22)
        }
        
        signUpButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.41)
            $0.height.equalTo(48)
        }
    }

    @objc override func keyboardWillHide(_ sender: Notification) {
        textFieldStackView.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.35)
        }
        
        signUpButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }

    // MARK: - Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "비밀번호 설정"
    }
    
    // MARK: - Add View
    override func addView() {
        [passwordTextField, checkPasswordTextField].forEach { textFieldStackView.addArrangedSubview($0) }
        [textFieldStackView, conditionsLabel, signUpButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.35)
        }
        
        conditionsLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(textFieldStackView.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
}

extension PasswordSettingViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if passwordTextField.text != "", checkPasswordTextField.text != "" {
            checkPasswordTextField.resignFirstResponder()
            return true
        } else if passwordTextField.text != "" {
            checkPasswordTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            viewModel.setupPassword(password: textField.text ?? "", checkPassword: checkPasswordTextField.text ?? "")
        }
    }
}
