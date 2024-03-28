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
    private let emailTextField = GOMSTextField()
    
    private let passwordTextField = GOMSTextField()
    
    private let findPasswordLabel = UILabel().then {
        $0.text = "비밀번호를 잊으셨나요?"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
    }
    
    private let authenticationNumberButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증번호 받기")
    
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Seletors
    @objc func findPasswordButtonTapped() {
        let findPasswordVC = FindPasswordViewController()
        navigationController?.pushViewController(findPasswordVC, animated: true)
    }
    
    @objc func authenticationNumberButtonTapped() {
        let authenticationNumberVC = AuthenticationNumberViewController()
        navigationController?.pushViewController(authenticationNumberVC, animated: true)
    }
    
    // MARK: - Navigaiton
    override func configNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "로그인"
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        
    }
    
    // MARK: - Add View
    override func addView() {
        [emailTextField, passwordTextField, findPasswordLabel, findPasswordButton, authenticationNumberButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
            $0.top.equalToSuperview().inset(241)
            $0.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
            $0.top.equalTo(emailTextField.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        findPasswordLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.equalToSuperview().inset(28)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(passwordTextField.snp.bottom)
        }
        
        authenticationNumberButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(138)
        }
    }
}
