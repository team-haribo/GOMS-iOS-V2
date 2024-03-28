//
//  AuthenticationNumberViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class AuthenticationNumberViewController: BaseViewController {
    
    // MARK: - Properties
    private lazy var textFieldStackView = UIStackView().then {
        $0.spacing = 16
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let authenticationNumberTextField1 = GOMSTextField()
    
    private let authenticationNumberTextField2 = GOMSTextField()
    
    private let authenticationNumberTextField3 = GOMSTextField()
    
    private let authenticationNumberTextField4 = GOMSTextField()
    
    private let timeLabel = UILabel().then {
        $0.text = "5:00"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let resendButton = UIButton().then {
        $0.setTitle("재발송", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
    }
    
    private lazy var authButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증")
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Navigation
    override func configNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "회원가입"
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        let authenticationNumberTextFields = [
            authenticationNumberTextField1,
            authenticationNumberTextField2,
            authenticationNumberTextField3,
            authenticationNumberTextField4
        ]

        authenticationNumberTextFields.forEach { textField in
            textField.font = .pretendard(size: 24, weight: .semibold)
            textField.addPadding(paddingFrame: CGRect(x: 0, y: 0, width: 28, height: 64))
        }
    }
    
    // MARK: - Add View
    override func addView() {
        [authenticationNumberTextField1, authenticationNumberTextField2, authenticationNumberTextField3, authenticationNumberTextField4].forEach { textFieldStackView.addArrangedSubview($0) }
        
        [textFieldStackView, timeLabel, resendButton, authButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        authenticationNumberTextField1.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        authenticationNumberTextField2.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        authenticationNumberTextField3.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        authenticationNumberTextField4.snp.makeConstraints {
            $0.height.equalTo(72)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(268)
        }
        
        timeLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().inset(28)
            $0.top.equalTo(textFieldStackView.snp.bottom)
        }
        
        resendButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(textFieldStackView.snp.bottom)
            $0.trailing.equalToSuperview().inset(28)
        }
        
        authButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(138)
            $0.height.equalTo(48)
        }
    }
}
