//
//  AuthenticationNumberViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class AuthNumberViewController: BaseViewController {
    
    // MARK: - Properties
    private var viewModel = SignUpViewModel()
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var textFieldStackView = UIStackView().then {
        $0.spacing = 16
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let authNumberTextField1 = GOMSTextField()
    
    private let authNumberTextField2 = GOMSTextField()
    
    private let authNumberTextField3 = GOMSTextField()
    
    private let authNumberTextField4 = GOMSTextField()
    
    private let timeLabel = UILabel().then {
        $0.text = "5:00"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private lazy var resendButton = UIButton().then {
        $0.setTitle("재발송", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
    }
    
    private let authError = UILabel().then {
        $0.text = "잘못된 인증번호입니다"
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.isHidden = true
    }
    
    private lazy var authButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증").then {
        $0.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        authNumberTextField1.delegate = self
        authNumberTextField2.delegate = self
        authNumberTextField3.delegate = self
        authNumberTextField4.delegate = self
    }
    
    // MARK: - Selectors
    @objc func resendButtonTapped() {
        
    }
    
    @objc func authButtonTapped() {
        viewModel.verifyAuthNumber { success in
            if success {
                let setPasswordVC = PasswordSettingViewController(viewModel: self.viewModel)
                self.navigationController?.pushViewController(setPasswordVC, animated: true)
            } else {
                self.authCodeError()
            }
        }
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        textFieldStackView.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.33)
        }
        
        authButton.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.42)
            $0.height.equalTo(48)
        }
    }
    
    @objc override func keyboardWillHide(_ sender: Notification) {
        textFieldStackView.snp.remakeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.49)
        }
        
        authButton.snp.remakeConstraints {
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
        navigationItem.title = "인증번호 입력"
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        let authNumberTextFields = [
            authNumberTextField1,
            authNumberTextField2,
            authNumberTextField3,
            authNumberTextField4
        ]

        authNumberTextFields.forEach { textField in
            textField.font = .pretendard(size: 24, weight: .semibold)
            textField.addPadding(paddingFrame: CGRect(x: 0, y: 0, width: 28, height: 64))
        }
    }
    
    // MARK: - Add View
    override func addView() {
        [authNumberTextField1, authNumberTextField2, authNumberTextField3, authNumberTextField4].forEach { textFieldStackView.addArrangedSubview($0) }
        
        [textFieldStackView, timeLabel, resendButton, authError, authButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        authNumberTextField1.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        authNumberTextField2.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        authNumberTextField3.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        authNumberTextField4.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.49)
        }
        
        timeLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.07)
            $0.top.equalTo(textFieldStackView.snp.bottom)
        }
        
        resendButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(textFieldStackView.snp.bottom)
            $0.trailing.equalTo(-bounds.width * 0.07)
        }
        
        authError.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(textFieldStackView.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.07)
        }
        
        authButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
    
    func authCodeError() {
        authNumberTextField1.layer.borderColor = .init(red: 0.89, green: 0.21, blue: 0.13, alpha: 1)
        authNumberTextField2.layer.borderColor = .init(red: 0.89, green: 0.21, blue: 0.13, alpha: 1)
        authNumberTextField3.layer.borderColor = .init(red: 0.89, green: 0.21, blue: 0.13, alpha: 1)
        authNumberTextField4.layer.borderColor = .init(red: 0.89, green: 0.21, blue: 0.13, alpha: 1)
        authError.isEnabled = false
    }
}

extension AuthNumberViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text!.count < 1 else { return false }
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            authButton.isEnabled = true
        } else {
            authButton.isEnabled = false
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == authNumberTextField1 {
            viewModel.setupAuthNumber(authNumber: textField.text ?? "")
        } else if textField == authNumberTextField2 {
            viewModel.setupAuthNumber(authNumber: textField.text ?? "")
        } else if textField == authNumberTextField3 {
            viewModel.setupAuthNumber(authNumber: textField.text ?? "")
        } else if textField == authNumberTextField4 {
            viewModel.setupAuthNumber(authNumber: textField.text ?? "")
        }
    }
}
