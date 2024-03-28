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
    private lazy var textFieldStackView = UIStackView().then {
        $0.spacing = 32
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let nameTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "이름")

    private let emailTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 64), placeholder: "이메일")
    
    private let defaultDomain = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private lazy var genderTextField = GOMSTextFieldButton(frame: CGRect(x: 0, y: 0, width: 0, height: 64), title: "성별").then {
        $0.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
    }
    
    private lazy var departmentTextField = GOMSTextFieldButton(frame: CGRect(x: 0, y: 0, width: 0, height: 64), title: "과").then {
        $0.addTarget(self, action: #selector(departmentButtonTapped), for: .touchUpInside)
    }
    
    private lazy var authenticationNumberButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "인증번호 받기").then {
        $0.addTarget(self, action: #selector(authenticationNumberButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Selectors
    @objc func genderButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let menAction = UIAlertAction(title: "남성", style: .default) { _ in
            self.genderTextField.setTitle("남성", for: .normal)
            self.genderTextField.setTitleColor(.white, for: .normal)
        }
        let womanAction = UIAlertAction(title: "여성", style: .default) { _ in
            self.genderTextField.setTitle("여성", for: .normal)
            self.genderTextField.setTitleColor(.white, for: .normal)
        }
        
        [ menAction, womanAction ].forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func departmentButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let swAction = UIAlertAction(title: "SW개발과", style: .default) { _ in
            self.departmentTextField.setTitle("SW개발과", for: .normal)
            self.departmentTextField.setTitleColor(.white, for: .normal)
        }
        let iotAction = UIAlertAction(title: "스마트IoT과", style: .default) { _ in
            self.departmentTextField.setTitle("스마트IoT과", for: .normal)
            self.departmentTextField.setTitleColor(.white, for: .normal)
        }
        let aiAction = UIAlertAction(title: "AI개발과", style: .default) { _ in
            self.departmentTextField.setTitle("AI개발과", for: .normal)
            self.departmentTextField.setTitleColor(.white, for: .normal)
        }
        
        [ swAction, iotAction, aiAction ].forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func authenticationNumberButtonTapped() {
        let authenticationNumberVC = AuthenticationNumberViewController()
        navigationController?.pushViewController(authenticationNumberVC, animated: true)
    }
    
    override func configNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "회원가입"
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
    }
    
    // MARK: - Add View
    override func addView() {
        emailTextField.addSubview(defaultDomain)
        
        [nameTextField, emailTextField, genderTextField, departmentTextField].forEach {
            self.textFieldStackView.addArrangedSubview($0)
        }
        
        [textFieldStackView, authenticationNumberButton].forEach { view.addSubview($0) }
    }

    // MARK: - Layout
    override func setLayout() {
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        defaultDomain.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        
        genderTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        departmentTextField.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(226)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        authenticationNumberButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(138)
            $0.height.equalTo(48)
        }
    }
}
