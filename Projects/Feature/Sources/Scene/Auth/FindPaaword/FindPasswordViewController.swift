//
//  FindPasswordViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class FindPasswordViewController: BaseViewController {
    
    // MARK: - Properties
    private let emailTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "이메일")
    
    private let defaultDomain = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let authButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증번호 받기")
    
    // MARK:  - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func configNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "비밀번호 재설정"
    }
    
    // MARK: - Add View
    override func addView() {
        emailTextField.addSubview(defaultDomain)
        [emailTextField, authButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        defaultDomain.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
            $0.top.equalToSuperview().inset(309)
        }
        
        authButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(138)
        }
    }
}
