//
//  OutingStatusCollectionViewCell.swift
//  Feature
//
//  Created by 새미 on 1/12/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then
import Kingfisher

final class OutingStatusCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "OutingStatusCell"
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28)).then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = .color.gomsSecondary.color
    }
    
    let nameLabel = UILabel().then {
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    let studentInformationLabel = UILabel().then {
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
    
    func configureData(with outingData: OutingListData) {
        if let imageURL = outingData.profileImageURL, let url = URL(string: imageURL) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"))
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        }
        nameLabel.text = outingData.name
        studentInformationLabel.text = "\(outingData.grade)기 | \(outingData.major)"
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentInformationLabel].forEach { contentView.addSubview($0) }
    }
    
    // MARK: - Layout
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(28)
            $0.leading.equalToSuperview().inset(-((bounds.width) / 23.4375))
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.leading.equalTo(profileImageView.snp.trailing).offset((bounds.width) / 46.875)
            $0.centerY.equalToSuperview()
        }
        
        studentInformationLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset((bounds.width) / 23.4375)
        }
    }
}
