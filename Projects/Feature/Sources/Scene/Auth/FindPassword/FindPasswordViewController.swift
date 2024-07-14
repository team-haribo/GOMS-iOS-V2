//
//  FindPasswordViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class FindPasswordViewController: BaseViewController {
    
    // MARK: - Properties
    private var viewModel = AuthViewModel()
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let emailTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "이메일")
    
    private let defaultDomain = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    let emailErrorLabel = UILabel().then {
        $0.text = "존재하지 않는 이메일입니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
    }
    
    private lazy var authCodeButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증번호 받기").then {
        $0.addTarget(self, action: #selector(authCodeButtonTapped), for: .touchUpInside)
    }
    
    // MARK:  - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
    }
    
    // MARK: - Selectors
    @objc func authCodeButtonTapped() {
        if emailTextField.text?.count != 6 {
            emailBlankValue()
        } else {
            viewModel.setupEmail(email: self.emailTextField.text ?? "")
            viewModel.setupEmailStatus(emailStatus: "AFTER_SIGNUP")
            viewModel.sendAuthCode { success, statusCode in
                if statusCode == 204 {
                    self.successUI()
                    let authCodeVC = AuthCodeViewController(viewModel: self.viewModel, previousViewController: self, email: self.emailTextField.text ?? "")
                    self.navigationController?.pushViewController(authCodeVC, animated: true)
                } else if statusCode == 404 {
                    self.nonExistentUser()
                } else {
                    self.emailErrorUI()
                }
            }
        }
    }
    
    func emailBlankValue() {
        emailTextField.setPlaceholderColor(.color.gomsNegative.color)
        defaultDomain.textColor = .color.gomsNegative.color
        emailErrorLabel.text = "유효한 이메일을 입력해주세요."
        emailErrorLabel.isHidden = false
        emailTextField.layer.borderColor = UIColor.systemRed.cgColor
        emailTextField.layer.borderWidth = 1
    }
    
    func nonExistentUser() {
        emailTextField.setPlaceholderColor(.color.gomsNegative.color)
        defaultDomain.textColor = .color.gomsNegative.color
        emailErrorLabel.text = "존재하지 않는 사용자입니다."
        emailErrorLabel.isHidden = false
        emailTextField.layer.borderColor = UIColor.systemRed.cgColor
        emailTextField.layer.borderWidth = 1
    }
    
    func successUI() {
        emailTextField.setPlaceholderColor(.color.gomsTertiary.color)
        defaultDomain.textColor = .color.gomsTertiary.color
        emailErrorLabel.isHidden = true
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        emailTextField.layer.borderWidth = 0
    }
    
    func emailErrorUI() {
        emailTextField.setPlaceholderColor(.color.gomsNegative.color)
        defaultDomain.textColor = .color.gomsNegative.color
        emailErrorLabel.isHidden = false
        emailTextField.layer.borderColor = UIColor.systemRed.cgColor
        emailTextField.layer.borderWidth = 1
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        authCodeButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(48)
            $0.bottom.equalTo(-bounds.height * 0.43)
        }
    }

    @objc override func keyboardWillHide(_ sender: Notification) {
        authCodeButton.snp.remakeConstraints {
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
        navigationItem.title = "비밀번호 찾기"
    }
    
    // MARK: - Add View
    override func addView() {
        emailTextField.addSubview(defaultDomain)
        [emailTextField, emailErrorLabel, authCodeButton].forEach { view.addSubview($0) }
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
            $0.height.equalTo(56)
            $0.top.equalTo(bounds.height * 0.21)
        }
        
        emailErrorLabel.snp.makeConstraints {
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.height.equalTo(48)
            $0.top.equalTo(emailTextField.snp.bottom)
        }
        
        authCodeButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(48)
            $0.bottom.equalTo(-bounds.height * 0.16)
        }
    }
}

extension FindPasswordViewController: UITextFieldDelegate {
    public func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTextField {
            viewModel.setupEmail(email: emailTextField.text ?? "")
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == emailTextField {
                let currentText = textField.text ?? ""
                guard let stringRange = Range(range, in: currentText) else { return false }
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                return updatedText.count <= 6
            }
            return true
        }
}
