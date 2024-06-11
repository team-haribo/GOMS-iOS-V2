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
    private var viewModel = AuthViewModel()
    
    public init(viewModel: AuthViewModel) {
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
    
    let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    let passwordErrorLabel = UILabel().then {
        $0.text = "잘못된 비밀번호입니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
    }
    
    lazy var visiblePasswordButton = UIButton().then {
        $0.setImage(.image.visible.image, for: .normal)
        $0.addTarget(self, action: #selector(visiblePasswordButtonTapped), for: .touchUpInside)
    }
    
    private let checkPasswordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호 확인").then {
        $0.isSecureTextEntry = true
    }
    
    private let conditionsLabel = UILabel().then {
        $0.text = "대/소문자, 특수문자 포함 6~15자"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    lazy var doneButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "완료").then {
        $0.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AuthViewModel()
        
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
    }
    
    // MARK: - Seletors
    @objc func doneButtonTapped() {
        print("New Password Setting Done")
        viewModel.setupNewPassword(newPassword: passwordTextField.text ?? "", checkPassword: checkPasswordTextField.text ?? "")
        viewModel.newPassword { success in
            if success {
                let alert = UIAlertController(title: "재설정 완료", message: "비밀번호가 재설정되었습니다.\n로그인 화면으로 돌아갑니다.", preferredStyle: .alert)
                
                let check = UIAlertAction(title: "확인", style: .default) { action in
                    let loginVC = SignInViewController(viewModel: self.viewModel)
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
                alert.addAction(check)
                self.present(alert, animated: true)
            }
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
    
    func passswordError() {
        passwordTextField.setBorderColorMode(lightModeColor: .color.gomsNegative.color, darkModeColor: .color.gomsNegative.color)
        passwordTextField.setPlaceholderColor(.color.gomsNegative.color)
        passwordErrorLabel.isHidden = false
    }

    // MARK: - Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "비밀번호 재설정"
    }
    
    // MARK: - Add View
    override func addView() {
        passwordTextField.addSubview(visiblePasswordButton)
        [passwordTextField, checkPasswordTextField].forEach { textFieldStackView.addArrangedSubview($0) }
        [textFieldStackView, conditionsLabel, doneButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.21)
        }
        
        visiblePasswordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
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
