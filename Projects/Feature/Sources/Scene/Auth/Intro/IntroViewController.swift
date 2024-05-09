//
//  SignInViewController.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class IntroViewController: BaseViewController {

    // MARK: - Properties
    let viewModel = AuthViewModel()
    
    private let gomsLogoImage = UIImageView(image: .image.gomsGoms.image)
    
    private let mainLable = UILabel().then {
        let range = NSRange(location: 0, length: 6)
        $0.text = "수요 외출제 관리 서비스"
        $0.textColor = .color.gomsTextDefault.color
        $0.setTextColor(.color.gomsPrimary.color, range: range)
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "앱으로 간편하게 GSM의\n수요 외출제를 이용해 보세요!"
        $0.numberOfLines = 2
        $0.setLineSpacing(spacing: 8)
        $0.textAlignment = .center
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    private lazy var signInButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "로그인").then {
        $0.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    private let divLineView1 = UIView().then {
        $0.setDynamicBackgroundColor(darkModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.15), lightModeColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05))
    }
    
    private let firstText = UILabel().then {
        $0.text = "처음이라면"
        $0.font = .pretendard(size: 12, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let divLineView2 = UIView().then {
        $0.setDynamicBackgroundColor(darkModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.15), lightModeColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05))
    }
    
    private lazy var signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
    }
    
    // MARK: - Seletors
    @objc func signInButtonTapped() {
        let signInVC = SignInViewController(viewModel: self.viewModel)
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // MARK: - Add View
    override func addView() {
        [gomsLogoImage, mainLable, descriptionLabel, signInButton, divLineView1, firstText, divLineView2, signUpButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        gomsLogoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bounds.height * 0.3)
            $0.width.height.equalTo(80)
        }
        
        mainLable.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.centerX.equalTo(bounds.width * 0.5)
            $0.top.equalTo(gomsLogoImage.snp.bottom).offset(56)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.centerX.equalTo(bounds.width * 0.5)
            $0.top.equalTo(mainLable.snp.bottom).offset(8)
        }
        
        signInButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(firstText.snp.top).offset(-18)
        }
        
        firstText.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(signUpButton.snp.top).offset(-2)
        }
        
        divLineView1.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-11.5)
            $0.trailing.equalTo(firstText.snp.leading).offset(-4)
            $0.height.equalTo(1)
        }
        
        divLineView2.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-11.5)
            $0.height.equalTo(1)
            $0.leading.equalTo(firstText.snp.trailing).offset(4)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.bottom.equalTo(-bounds.height * 0.06)
            $0.centerX.equalTo(bounds.width * 0.5)
        }
    }
}
