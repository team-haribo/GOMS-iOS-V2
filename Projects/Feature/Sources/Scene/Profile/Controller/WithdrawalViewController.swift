//
//  WithdrawalViewController.swift
//  Feature
//
//  Created by 새미 on 5/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public class WithdrawalViewController: BaseViewController, UITextFieldDelegate {

    // MARK: - Properties
    private let viewModel = ProfileViewModel()
    
    let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "현재 비밀번호")
    
    lazy var visiblePasswordButton = UIButton().then {
        $0.setImage(.image.visible.image, for: .normal)
        $0.addTarget(self, action: #selector(visiblePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var withdrawalButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "회원 탈퇴하기").then {
        $0.addTarget(self, action: #selector(withdrawalButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
    }
    
    // MARK: - Selectors
    @objc func withdrawalButtonTapped() {
        viewModel.setupPassword(password: passwordTextField.text ?? "")
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
            $0.top.equalTo(-bounds.height * 0.41)
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
        [passwordTextField, withdrawalButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(bounds.height * 0.21)
            $0.height.equalTo(56)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
}
