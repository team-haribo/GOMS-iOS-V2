//
//  WithdrawalViewController.swift
//  Feature
//
//  Created by 새미 on 5/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public class WithdrawalViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel = ProfileViewModel()
    
    let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "현재 비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    lazy var visiblePasswordButton = UIButton().then {
        $0.setImage(.image.visible.image, for: .normal)
        $0.addTarget(self, action: #selector(visiblePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var withdrawalButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "회원 탈퇴하기").then {
        $0.addTarget(self, action: #selector(withdrawalButtonTapped), for: .touchUpInside)
    }
    
    
    let passwordErrorLabel = UILabel().then {
        $0.text = "잘못된 비밀번호입니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
    }
    
    // MARK: - Selectors
    @objc func withdrawalButtonTapped() {
        viewModel.setupPassword(password: passwordTextField.text ?? "")
        viewModel.withdraw { success in
            if success {
                let alert = UIAlertController(title: "회원 탈퇴 완료", message: "그동안 GOMS를 이용해주셔서 감사합니다.\n안녕히 가세요!", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "완료", style: .default) { _ in
                    let introVC = IntroViewController()
                    self.navigationController?.pushViewController(introVC, animated: true)
                }
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                print("탈퇴하기 실패")
                self.passwordErrorUI()
            }
        }
    }
    
    func passwordErrorUI() {
        passwordTextField.setPlaceholderColor(.color.gomsNegative.color)
        passwordErrorLabel.isHidden = false
        passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        passwordTextField.layer.borderWidth = 1
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
        withdrawalButton.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(-bounds.height * 0.41)
            $0.height.equalTo(48)
        }
    }

    @objc override func keyboardWillHide(_ sender: Notification) {
        withdrawalButton.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
    
    // MARK: - Configure Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "회원 탈퇴"
    }
    
    // MARK: - Add View
    override func addView() {
        passwordTextField.addSubview(visiblePasswordButton)
        [passwordTextField, withdrawalButton, passwordErrorLabel].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(bounds.height * 0.21)
            $0.height.equalTo(56)
        }
        
        passwordErrorLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        visiblePasswordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
}

// MARK: - Extension
extension WithdrawalViewController: UITextFieldDelegate {
    public func textFieldDidChange(_ textField: UITextField) {
        if textField == passwordTextField {
            viewModel.setupPassword(password: textField.text ?? "")
        }
    }
}

