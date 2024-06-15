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
    
    let noneInputError = UILabel().then {
        $0.text = "입력되지 않았습니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    // MARK: - Selectors
    @objc func genderButtonTapped() {
        view.endEditing(true)
        
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
        view.endEditing(true)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let swAction = UIAlertAction(title: "SW개발과", style: .default) { _ in
            self.majorTextField.setTitle("SW개발과", for: .normal)
            self.majorTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupMajor(major: "SW_DEVELOP")
        }
        let iotAction = UIAlertAction(title: "스마트IoT과", style: .default) { _ in
            self.majorTextField.setTitle("스마트IoT과", for: .normal)
            self.majorTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupMajor(major: "SMART_IOT")
        }
        let aiAction = UIAlertAction(title: "AI개발과", style: .default) { _ in
            self.majorTextField.setTitle("AI개발과", for: .normal)
            self.majorTextField.setTitleColor(.color.gomsTextDefault.color, for: .normal)
            self.viewModel.setupMajor(major: "AI")
        }
        
        [ swAction, iotAction, aiAction ].forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func authCodeButtonTapped() {
        viewModel.setupEmail(email: emailTextField.text ?? "")
        viewModel.setupName(name: nameTextField.text ?? "")
        viewModel.sendAuthCode { success, statusCode in
            if success {
                let authCodeVC = AuthCodeViewController(viewModel: self.viewModel, previousViewController: self, email: self.emailTextField.text ?? "")
                self.navigationController?.pushViewController(authCodeVC, animated: true)
            } else {
                switch statusCode {
                case 429:
                    let alert = UIAlertController(title: "이메일 요청 초과", message: "이메일 요청 한도인 5번을 초과했습니다.\n다음에 다시 시도해 주세요.", preferredStyle: .alert)
                    
                    let check = UIAlertAction(title: "확인", style: .cancel)
                    alert.addAction(check)
                    self.present(alert, animated: true)
                    
                default:
                    let alert = UIAlertController(title: "인증코드 발송 실패", message: "인증코드 발송에 실패했습니다.\n다시 시도해 주세요.", preferredStyle: .alert)
                    
                    let check = UIAlertAction(title: "확인", style: .cancel)
                    alert.addAction(check)
                    self.present(alert, animated: true)
                    
                    print("재발송 실패")
                    print("Error: \(statusCode)")
                }
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

extension SignUpViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
