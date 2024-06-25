//
//  NewPasswordViewController.swift
//  Feature
//
//  Created by 새미 on 3/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class NewPasswordViewController: BaseViewController {

    // MARK: - Properties
    private var viewModel: AuthViewModel
    var email: String

    init(viewModel: AuthViewModel, email: String) {
        self.viewModel = viewModel
        self.email = email
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
    
    let passwordErrorLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
    }
    
    let passwordWrongRegularExpression = UILabel().then {
        $0.text = "잘못된 비밀번호입니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
    }
    
    let passwordOverlapErrorLabel = UILabel().then {
        $0.text = "이미 사용중인 비밀번호입니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
    }
    
    lazy var passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
        $0.rightView = visiblePasswordButton
        $0.rightViewMode = .always
    }
    
    lazy var visiblePasswordButton = UIButton().then {
        $0.setImage(.image.visible.image, for: .normal)
        $0.addTarget(self, action: #selector(visiblePasswordButtonTapped), for: .touchUpInside)
        $0.isEnabled = true
    }
    
    private let checkPasswordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호 확인").then {
        $0.isSecureTextEntry = true
    }
    
    private let conditionsLabel = UILabel().then {
        $0.text = "대/소문자, 숫자, 특수문자 포함 6자 이상"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
     let doneButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "완료").then {
        $0.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
    }
    
    // MARK: - Seletors
    @objc func doneButtonTapped() {
        let defaults = UserDefaults.standard
        let localPassword = defaults.string(forKey: "localPass")
        self.validatePassword()
        let isValidPassword = self.validatePassword()
            
        viewModel.setupEmail(email: self.email)
        viewModel.setupNewServePassword(newPassword: passwordTextField.text ?? "", checkPassword: checkPasswordTextField.text ?? "")
        viewModel.setupPassword(password: localPassword ?? "")
        viewModel.newPassword { [self] success, statusCode in
            if !isValidPassword {
                        self.passwordWrongRegularExpressionUI()
                    
        } else if passwordTextField.text != checkPasswordTextField.text {
            self.passwordErrorUI()
            conditionsLabel.isHidden = true
        } else if passwordTextField.text == "" {
            self.passwordErrorUI()
        }
            else if !success {
                switch statusCode {
                case 400:
                    print("400")
                    self.passwordOverlapErrorUI()
                    conditionsLabel.isHidden = false
                case 404:
                    print("404")
                default:
                    print("Error: \(statusCode)")
                }
            } else if success {
                let defaults = UserDefaults.standard
                UserDefaults.standard.set(self.checkPasswordTextField.text, forKey: "localPass")
                let alert = UIAlertController(title: "재설정 완료", message: "비밀번호가 재설정되었습니다.\n로그인 화면으로 돌아갑니다.", preferredStyle: .alert)
                
                let check = UIAlertAction(title: "확인", style: .default) { action in
                    let loginVC = IntroViewController()
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
                
                passwordOverlapErrorLabel.isHidden = true
                passwordTextField.layer.borderWidth = 0
                passwordTextField.setPlaceholderColor(.color.gomsTertiary.color)
                
                passwordErrorLabel.isHidden = true
                checkPasswordTextField.layer.borderWidth = 0
                checkPasswordTextField.setPlaceholderColor(.color.gomsTertiary.color)
                
                alert.addAction(check)
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func visiblePasswordButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        checkPasswordTextField.isSecureTextEntry.toggle()
        passwordTextField.isSelected.toggle()
        checkPasswordTextField.isSelected.toggle()
        
        if passwordTextField.isSelected {
            visiblePasswordButton.setImage(.image.invisible.image, for: .normal)
        } else {
            visiblePasswordButton.setImage(.image.visible.image, for: .normal)
        }
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        doneButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(48)
            $0.bottom.equalTo(-bounds.height * 0.43)
        }
    }

    @objc override func keyboardWillHide(_ sender: Notification) {
        doneButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
    
    @objc private func validatePassword() -> Bool {
            guard let password = passwordTextField.text else { return false }
            
            let regexPattern = "^(?=.*[a-z])(?=.*\\d)(?=.*[\\W_])[A-Za-z\\d\\W_]{6,16}$"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
            let isValid = passwordTest.evaluate(with: password)
            
            if isValid {
                print("정규식에 알맞는 비밀번호입니다.")
            } else {
                print("정규식에 맞지 않는 비밀번호입니다.")
            }
            return isValid
        }
    
    func passwordErrorUI() {
        checkPasswordTextField.setPlaceholderColor(.color.gomsNegative.color)
        passwordErrorLabel.isHidden = false
        checkPasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
        checkPasswordTextField.layer.borderWidth = 1
        
        passwordOverlapErrorLabel.isHidden = true
        passwordWrongRegularExpression.isHidden = true
        passwordTextField.layer.borderWidth = 0
        passwordTextField.setPlaceholderColor(.color.gomsTertiary.color)
    }
    
    func passwordOverlapErrorUI() {
        passwordTextField.setPlaceholderColor(.color.gomsNegative.color)
        passwordOverlapErrorLabel.isHidden = false
        passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        passwordTextField.layer.borderWidth = 1
        
        passwordWrongRegularExpression.isHidden = true
        passwordErrorLabel.isHidden = true
        checkPasswordTextField.layer.borderWidth = 0
        checkPasswordTextField.setPlaceholderColor(.color.gomsTertiary.color)
    }
    
    func passwordWrongRegularExpressionUI() {
        passwordTextField.setPlaceholderColor(.color.gomsNegative.color)
        passwordWrongRegularExpression.isHidden = false
        passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        passwordTextField.layer.borderWidth = 1
        
        passwordOverlapErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        checkPasswordTextField.layer.borderWidth = 0
        checkPasswordTextField.setPlaceholderColor(.color.gomsTertiary.color)
    }

    // MARK: - Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "비밀번호 재설정"
    }
    
    // MARK: - Add View
    override func addView() {
        [passwordTextField, checkPasswordTextField].forEach { textFieldStackView.addArrangedSubview($0) }
        [textFieldStackView, conditionsLabel, doneButton,passwordErrorLabel,passwordOverlapErrorLabel, passwordWrongRegularExpression].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        passwordErrorLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(checkPasswordTextField.snp.bottom).inset(5)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        passwordOverlapErrorLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(passwordTextField.snp.bottom).inset(5)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        passwordWrongRegularExpression.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(passwordTextField.snp.bottom).inset(5)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.21)
        }
        
        conditionsLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(textFieldStackView.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        doneButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
}

// MARK: - Extension
extension NewPasswordViewController: UITextFieldDelegate {
    public func textFieldDidChange(_ textField: UITextField) {
        if textField == passwordTextField {
            viewModel.setupNewPassword(newPassword: passwordTextField.text ?? "", checkPassword: checkPasswordTextField.text ?? "")
        }
    }
    
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
}
