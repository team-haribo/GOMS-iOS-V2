//
//  ProfileCardView.swift
//  Feature
//
//  Created by 새미 on 1/12/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class ProfileCardView: UIView {
    
    // MARK: - Properties
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

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        self.backgroundColor = .color.gomsBackground.color
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.color.gomsTertiary.color.cgColor
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentIDLabel, myOutingStatusLabel].forEach { self.addSubview($0) }
    }
    
    // MARK: - Layout
    private func setLayout() {
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
    }
}
