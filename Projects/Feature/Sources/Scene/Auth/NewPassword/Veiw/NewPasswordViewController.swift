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
    private let viewModel = AuthViewModel()
    
    private let textFieldStackView = UIStackView().then {
        $0.spacing = 32
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호")
    
    private let checkPasswordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호 확인")
    
    private let conditionsLabel = UILabel().then {
        $0.text = "대/소문자, 특수문자 포함 6~15자"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private lazy var doneButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "완료").then {
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
        viewModel.newPassword {  success in
            if success {
                let alert = UIAlertController(title: "재설정 완료", message: "비밀번호가 재설정되었습니다.\n로그인 화면으로 돌아갑니다.", preferredStyle: .alert)
                
                let check = UIAlertAction(title: "확인", style: .default) { action in
                    let loginVC = SignInViewController()
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
                alert.addAction(check)
                self.present(alert, animated: true)
            }
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

    // MARK: - Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "비밀번호 재설정"
    }
    
    // MARK: - Add View
    override func addView() {
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


extension NewPasswordViewController: UITextFieldDelegate {
    public func textFieldDidChange(_ textField: UITextField) {
        if textField == passwordTextField {
            viewModel.setupPassword(password: passwordTextField.text ?? "", checkPassword: checkPasswordTextField.text ?? "")
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
