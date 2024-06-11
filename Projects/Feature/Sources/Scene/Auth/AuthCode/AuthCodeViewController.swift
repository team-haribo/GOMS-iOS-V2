//
//  AuthCodeViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class AuthCodeViewController: BaseViewController {
    
    // MARK: - Properties
    private var viewModel = AuthViewModel()
    private var previousViewController: UIViewController?
        
    init(viewModel: AuthViewModel, previousViewController: UIViewController?) {
        self.viewModel = viewModel
        self.previousViewController = previousViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var limitTime = 300
    
    private let authCodeTextField = GOMSTextField()
    
    private let timeLabel = UILabel().then {
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
        authCodeTextField.delegate = self
        getSetTime()
    }
    
    // MARK: - Selectors
    @objc func getSetTime() {
        secToTime(sec: limitTime)
        limitTime -= 1
    }
    
    @objc func resendButtonTapped() {
        viewModel.setupAuthCode(authCode: authCodeTextField.text ?? "")
        viewModel.sendAuthCode { success in print("인증번호 재발송") }
    }
    
    @objc func authButtonTapped() {
        viewModel.setupAuthCode(authCode: authCodeTextField.text ?? "")
        viewModel.verifyAuthCode { success in
            if success {
                self.authCodeSuccess()
                if let previousVC = self.previousViewController as? FindPasswordViewController {
                    let newPasswordVC = NewPasswordViewController(viewModel: self.viewModel)
                    self.navigationController?.pushViewController(newPasswordVC, animated: true)
                } else if let previousVC = self.previousViewController as? SignUpViewController {
                    let passwordSettingVC = PasswordSettingViewController(viewModel: self.viewModel)
                    self.navigationController?.pushViewController(passwordSettingVC, animated: true)
                }
            } else {
                self.authCodeError()
            }
        }
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        authButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.42)
            $0.height.equalTo(48)
        }
    }
    
    @objc override func keyboardWillHide(_ sender: Notification) {
        authButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(-bounds.height * 0.16)
            $0.height.equalTo(48)
        }
    }
    
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            timeLabel.text = String(minute) + ":" + "0"+String(second)
        } else {
            timeLabel.text = String(minute) + ":" + String(second)
        }
        
        if limitTime != 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        } else if limitTime == 0 {
            timeLabel.text = "00:00"
        }
    }

    // MARK: - Navigation
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "인증번호 입력"
    }
    
    // MARK: - Add View
    override func addView() {
        [authCodeTextField, timeLabel, resendButton, authError, authButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        authCodeTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.21)
        }
        
        timeLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.07)
            $0.top.equalTo(authCodeTextField.snp.bottom)
        }
        
        resendButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(authCodeTextField.snp.bottom)
            $0.trailing.equalTo(-bounds.width * 0.07)
        }
        
        authError.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(authCodeTextField.snp.bottom)
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
        timeLabel.isHidden = true
        authError.isHidden = false
    }
    
    func authCodeSuccess() {
        timeLabel.isHidden = false
        authError.isHidden = true
    }
}

extension AuthCodeViewController: UITextFieldDelegate {
    public func textFieldDidChange(_ textField: UITextField) {
        if textField == authCodeTextField {
            viewModel.setupAuthCode(authCode: textField.text ?? "")
        }
    }
}
