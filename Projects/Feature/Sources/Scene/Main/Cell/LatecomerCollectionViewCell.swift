//
//  LatecomerCollectionViewCell.swift
//  Feature
//
//  Created by 새미 on 1/12/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class LatecomerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56)).then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    let studentIDLabel = UILabel().then {
        $0.text = "1학년 5반 1번"
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
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
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentIDLabel].forEach { contentView.addSubview($0) }
    }
    
    // MARK: - Layout
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
        
        studentIDLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
