//
//  LateCell.swift
//  Feature
//
//  Created by 새미 on 4/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class LateCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "LateCell"

    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56)).then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = .color.gomsTertiary.color
    }
    
    let nameLabel = UILabel().then {
        $0.font = .pretendard(size: 16, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .color.gomsSecondary.color
        $0.text = "김새미"
    }
    
    let studentInformationLabel = UILabel().then {
        $0.font = .pretendard(size: 12, weight: .regular)
        $0.textAlignment = .center
        $0.textColor = .color.gomsTertiary.color
        $0.text = "6기 | 스마트 IOT"
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .color.gomsCardBackgroundColor.color
        
        addView()
        configureUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentInformationLabel].forEach {
            self.addSubview($0)
        }
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        self.backgroundColor = .color.gomsCardBackgroundColor.color
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(56)
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        studentInformationLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
