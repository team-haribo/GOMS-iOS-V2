//
//  SignUpViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class SignUpViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel = AuthViewModel()
    
    private lazy var textFieldStackView = UIStackView().then {
        $0.spacing = 32
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    let nameTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "이름")
    
    private let emailTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "이메일")
    
    private let defaultDomain = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    lazy var genderTextField = GOMSTextFieldButton(frame: CGRect(x: 0, y: 0, width: 0, height: 64), title: "성별").then {
        $0.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
    }
    
    lazy var majorTextField = GOMSTextFieldButton(frame: CGRect(x: 0, y: 0, width: 0, height: 64), title: "과").then {
        $0.addTarget(self, action: #selector(departmentButtonTapped), for: .touchUpInside)
    }
    
    private lazy var authCodeButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증번호 받기").then {
        $0.addTarget(self, action: #selector(authCodeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    // MARK: - Selectors
    @objc func genderButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let menAction = UIAlertAction(title: "남성", style: .default) { _ in
            self.genderTextField.setTitle("남성", for: .normal)
            self.genderTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupGender(gender: "MAN")
        }
        let womanAction = UIAlertAction(title: "여성", style: .default) { _ in
            self.genderTextField.setTitle("여성", for: .normal)
            self.genderTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupGender(gender: "WOMAN")
        }
        
        [ menAction, womanAction ].forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func departmentButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let swAction = UIAlertAction(title: "SW개발과", style: .default) { _ in
            self.majorTextField.setTitle("SW개발과", for: .normal)
            self.genderTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupMajor(major: "SW_DEVELOP")
        }
        let iotAction = UIAlertAction(title: "스마트IoT과", style: .default) { _ in
            self.majorTextField.setTitle("스마트IoT과", for: .normal)
            self.genderTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupMajor(major: "SMART_IOT")
        }
        let aiAction = UIAlertAction(title: "AI개발과", style: .default) { _ in
            self.majorTextField.setTitle("AI개발과", for: .normal)
            self.genderTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupMajor(major: "AI")
        }
        
        [ swAction, iotAction, aiAction ].forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func authCodeButtonTapped() {
        viewModel.setupEmail(email: emailTextField.text ?? "")
        viewModel.setupName(name: nameTextField.text ?? "")
        viewModel.sendAuthCode { success in
            if success {
                let authCodeVC = AuthCodeViewController(viewModel: self.viewModel,  previousViewController: self, email: "")
                self.navigationController?.pushViewController(authCodeVC, animated: true)
            }
        }
    }
    
    // MARK: - Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "회원가입"
    }
    
    // MARK: - Add View
    override func addView() {
        emailTextField.addSubview(defaultDomain)
        [nameTextField, emailTextField, genderTextField, majorTextField].forEach {
            self.textFieldStackView.addArrangedSubview($0)
        }
        [textFieldStackView, authCodeButton].forEach { view.addSubview($0) }
    }

    // MARK: - Layout
    override func setLayout() {
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        defaultDomain.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        
        genderTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        majorTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(bounds.height * 0.21)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
        }
        
        authCodeButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
}

// MARK: - Extension
extension SignUpViewController: UITextFieldDelegate {
    public func textFieldDidChange(_ textField: UITextField) {
        if textField == nameTextField {
            viewModel.setupName(name: self.nameTextField.text ?? "")
        } else if textField == emailTextField {
            viewModel.setupEmail(email: self.emailTextField.text ?? "")
        }
    }
}
