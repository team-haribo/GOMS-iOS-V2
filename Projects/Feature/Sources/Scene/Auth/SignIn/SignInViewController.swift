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
    private let gomsLogoImage = UIImageView(image: .image.gomsGoms.image)
    
    private let mainLable = UILabel().then {
        let range = NSRange(location: 0, length: 6)
        $0.text = "수요 외출제 관리 서비스"
        $0.setDynamicTextColor(darkModeColor: .white, lightModeColor: .black)
        $0.setTextColor(.color.gomsPrimary.color, range: range)
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "앱으로 간편하게 GSM의\n수요 외출제를 이용해 보세요!"
        $0.numberOfLines = 2
        $0.setLineSpacing(spacing: 7)
        $0.textAlignment = .center
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    private let loginButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "로그인")
    
    private let divLineView1 = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
    }
    
    private let firstText = UILabel().then {
        $0.text = "처음이라면"
        $0.font = .pretendard(size: 12, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let divLineView2 = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
    }
    
    private let signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
    }
    
    // MARK: - Add View
    override func addView() {
        [gomsLogoImage, mainLable, descriptionLabel, loginButton, divLineView1, firstText, divLineView2, signUpButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        gomsLogoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(258)
            $0.width.height.equalTo(80)
        }
        
        mainLable.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(gomsLogoImage.snp.bottom).offset(56)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLable.snp.bottom).offset(8)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(136)
        }
        
        firstText.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(18)
        }
        
        divLineView1.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(loginButton.snp.bottom).offset(27.5)
            $0.trailing.equalTo(firstText.snp.leading).offset(-4)
            $0.height.equalTo(1)
        }
        
        divLineView2.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(27.5)
            $0.height.equalTo(1)
            $0.leading.equalTo(firstText.snp.trailing).offset(4)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(firstText.snp.bottom).offset(2)
            $0.centerX.equalToSuperview().inset(50)
        }
    }
}
