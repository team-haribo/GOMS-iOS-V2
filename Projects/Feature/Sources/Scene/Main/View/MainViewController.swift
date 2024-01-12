//
//  MainViewController.swift
//  Feature
//
//  Created by 새미 on 1/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class MainViewController: BaseViewController {
    
    // MARK: - Properties
    private let logo = UIImageView(image: .image.gomsLogo.image)
    
    private let settingButton = UIButton().then {
        $0.setBackgroundImage(.image.gomsSettingIcon.image, for: .normal)
    }
    
    private let profileView = UIView().then {
        $0.backgroundColor = .color.gomsBackground.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsTertiary.color.cgColor
    }
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64)).then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.textColor = .white
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    let studentIDLabel = UILabel().then {
        $0.text = "1학년 5반 1번"
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
    }
    
    let myOutingStatusLabel = UILabel().then {
        $0.text = "외출 대기 중"
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    private let latecomerView = UIView().then {
        $0.backgroundColor = .color.gomsBackground.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsTertiary.color.cgColor
    }
    
    private let latecomerLabel = UILabel().then {
        $0.text = "지각자 TOP 3"
        $0.textColor = .white
        $0.font = UIFont.pretendard(size: 24, weight: .bold)
    }
    
    private let outingStatusView = UIView()
    
    private let outingStatusLabel = UILabel().then {
        $0.text = "외출 현황"
        $0.textColor = .white
        $0.font = UIFont.pretendard(size: 24, weight: .bold)
    }
    
    private let moreOutingStatusButton = UIButton()
    
    private let dividingLineView = UIView()
    
    let numberOfPeopleOutingLabel = UILabel().then {
        $0.text = "66명이 외출 중"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
    }
    
    private let QRButton = UIButton()
    
    // MARK: - Selectors
    @objc func settingButtonTapped() {
        // Setting ViewController 이동
    }

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    // MARK: - Add View
    override func addView() {
        [profileImageView, nameLabel, studentIDLabel, myOutingStatusLabel].forEach { profileView.addSubview($0) }
        [ latecomerLabel ].forEach { latecomerView.addSubview($0) }
        [logo, settingButton, profileView, latecomerView].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(20)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.86)
            $0.trailing.equalToSuperview().inset(20.92)
        }
        
        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(logo.snp.bottom).offset(32)
            $0.height.equalTo(96)
        }
        
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(15)
            $0.height.equalTo(32)
        }
        
        studentIDLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(15)
            $0.height.equalTo(28)
        }
        
        myOutingStatusLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        latecomerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(profileView.snp.bottom).offset(32)
            $0.height.equalTo(216)
        }
        
        latecomerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
    }
}
