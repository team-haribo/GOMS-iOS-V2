//
//  SignInViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import Service

public final class SignInViewController: BaseViewController {

    // MARK: - Properties
    private var viewModel = AuthViewModel()
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var listModel : StudentListModel?
    
    init(listModel: StudentListModel) {
        self.listModel = listModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var profileModel = ProfileViewModel()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var textFieldStackView = UIStackView().then {
        $0.spacing = 24
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
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
    
    private let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    lazy var visiblePasswordButton = UIButton().then {
        $0.setImage(.image.visible.image, for: .normal)
        $0.addTarget(self, action: #selector(visiblePasswordButtonTapped), for: .touchUpInside)
        $0.isEnabled = true
    }
    
    private let findPasswordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 48)).then {
        $0.text = "비밀번호를 잊으셨나요?"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    private lazy var findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
    }
    
    let passwordErrorLabel = UILabel().then {
        $0.text = "잘못된 비밀번호입니다."
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.isHidden = true
    }
    
    private lazy var signInButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "로그인").then {
        $0.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

    }
    
    // MARK: - Seletors
    @objc func findPasswordButtonTapped() {
        let findPasswordVC = FindPasswordViewController(viewModel: self.viewModel)
        navigationController?.pushViewController(findPasswordVC, animated: true)
    }
    
    @objc func signInButtonTapped() {
        viewModel.setupEmail(email: emailTextField.text ?? "")
        viewModel.setupPassword(password: passwordTextField.text ?? "")
        viewModel.signIn { statusCode in
            switch statusCode {
            case 200:
                self.signInSuccessUI()
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(self.passwordTextField.text, forKey: "localPass")
                let defaults = UserDefaults.standard
                let localPassword = defaults.string(forKey: "localPass")
                print(localPassword)
                self.profileModel.loadProfileInfo()
                let authority = self.profileModel.profileInfo?.authority
                if authority == "ROLE_STUDENT_COUNCIL" {
                    let mainVC = AdminMainViewController()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                } else if authority == "ROLE_STUDENT" {
                    let mainVC = MainViewController()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                } else {
                    print("권한이 없습니다.")
                }
            case 400:
                self.passwordErrorUI()
            case 404:
                self.emailErrorUI()
            default:
                print("Error")
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
        self.visiblePasswordButton.isEnabled = true
        self.signInButton.isEnabled = true
        signInButton.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.43)
        }
    }
    
    @objc override func keyboardWillHide(_ sender: Notification) {
        self.visiblePasswordButton.isEnabled = true
        self.signInButton.isEnabled = true
        signInButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
        }
    }
    
    func signInSuccessUI() {
        emailTextField.setPlaceholderColor(.color.gomsTertiary.color)
        defaultDomain.textColor = .color.gomsTertiary.color
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isEnabled = true
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        emailTextField.layer.borderWidth = 0
        findPasswordLabel.isHidden = false
        
        passwordTextField.snp.remakeConstraints {
            $0.height.equalTo(56)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(emailTextField.snp.bottom).offset(24)
        }
    }
    
    func emailErrorUI() {
        emailTextField.setPlaceholderColor(.color.gomsNegative.color)
        defaultDomain.textColor = .color.gomsNegative.color
        emailErrorLabel.isHidden = false
        emailTextField.layer.borderColor = UIColor.systemRed.cgColor
        emailTextField.layer.borderWidth = 1
        
        passwordTextField.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(emailErrorLabel.snp.bottom).offset(24)
        }
    }
    
    func passwordErrorUI() {
        passwordTextField.setPlaceholderColor(.color.gomsNegative.color)
        passwordErrorLabel.isHidden = false
        passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        passwordTextField.layer.borderWidth = 1
        findPasswordLabel.isHidden = true
    }
    
    // MARK: - Navigaiton
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "로그인"
    }
    
    // MARK: - Add View
    override func addView() {
        emailTextField.addSubview(defaultDomain)
        passwordTextField.addSubview(visiblePasswordButton)
        [emailTextField, emailErrorLabel, passwordTextField, passwordErrorLabel, findPasswordLabel, findPasswordButton, signInButton].forEach { view.addSubview($0) }
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
            $0.top.equalTo(bounds.height * 0.2)
            $0.height.equalTo(56)
        }
        
        emailErrorLabel.snp.makeConstraints {
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.height.equalTo(48)
            $0.top.equalTo(emailTextField.snp.bottom)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(emailTextField.snp.bottom).offset(24)
        }
        
        visiblePasswordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        findPasswordLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        passwordErrorLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.trailing.equalTo(-bounds.width * 0.07)
            $0.top.equalTo(passwordTextField.snp.bottom)
        }
        
        signInButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
        }
    }
}

// MARK: - Extension
extension SignInViewController: UITextFieldDelegate {
    public func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTextField {
            viewModel.setupEmail(email: textField.text ?? "")
        } else if textField == passwordTextField {
            viewModel.setupPassword(password: textField.text ?? "")
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
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.text != "", passwordTextField.text != "" {
            passwordTextField.resignFirstResponder()
            return true
        } else if emailTextField.text != "" {
            passwordTextField.becomeFirstResponder()
            return true
        }
        return false
    }
}
