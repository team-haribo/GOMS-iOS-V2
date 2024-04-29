//
//  LatecomerCollectionViewCell.swift
//  Feature
//
//  Created by 새미 on 4/27/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class LatecomerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "LatecomerCell"
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48)).then {
        $0.image = .image.gomsProfile.image
    }
    
    let nameLabel = UILabel().then {
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.text = "김새미"
    }
    
    let studentInfoLabel = UILabel().then {
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
        $0.text = "6기 | 김새미"
    }

    private let bottomView = UIView().then {
        $0.setDynamicBackgroundColor(darkModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.15), lightModeColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05))
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentInfoLabel, bottomView].forEach { contentView.addSubview($0)}
    }
    
    // MARK: - Layout
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.height.equalTo(28)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        studentInfoLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
