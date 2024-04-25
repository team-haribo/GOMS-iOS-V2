//
//  AdminOutingCollectionViewCell.swift
//  Feature
//
//  Created by 새미 on 2/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then

protocol AdminOutingCellDelegate: AnyObject {
    func deleteButtonTapped(index: Int)
}

final class AdminOutingCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "AdminOutingStatusCell"
    weak var delegate: AdminOutingCellDelegate?
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
    
    let nameLabel = UILabel().then {
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    let studentInformationLabel = UILabel().then {
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    private let divLine = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.15)
    }
    
    let outingTime = UILabel().then {
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    private let bottomView = UIView().then {
        $0.setDynamicBackgroundColor(darkModeColor: .white.withAlphaComponent(0.15), lightModeColor: .black.withAlphaComponent(0.15))
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(.image.gomsDeleteIcon.image, for: .normal)
        $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
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
    
    @objc private func deleteButtonTapped() {
        delegate?.deleteButtonTapped(index: self.tag)
    }
    
    func configureData(with outingData: OutingListData) {
        if let imageURL = outingData.profileImageURL, let url = URL(string: imageURL) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"))
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        }
        nameLabel.text = outingData.name
        studentInformationLabel.text = "\(outingData.grade)기 | \(outingData.major)"
        outingTime.text = "\(outingData.outingTime)에 외출"
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentInformationLabel, divLine, outingTime, deleteButton, bottomView].forEach { contentView.addSubview($0)}
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
        
        studentInformationLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        divLine.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.width.equalTo(1)
            $0.bottom.equalToSuperview().inset(18)
            $0.leading.equalTo(studentInformationLabel.snp.trailing).offset(4)
        }
        
        outingTime.snp.makeConstraints {
            $0.leading.equalTo(divLine.snp.trailing).offset(4)
            $0.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(24)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
