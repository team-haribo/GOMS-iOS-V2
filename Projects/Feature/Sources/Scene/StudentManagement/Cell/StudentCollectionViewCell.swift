//
//  StudentCollectionViewCell.swift
//  Feature
//
//  Created by 새미 on 5/2/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then
import Kingfisher

public final class StudentCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let identifier = "StudentCell"
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
    
    let nameLabel = UILabel().then {
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    let studentInfoLabel = UILabel().then {
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    private let divLine = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.15)
    }
    
    private let bottomView = UIView().then {
        $0.setDynamicBackgroundColor(darkModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.15), lightModeColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05))
    }
    
    private lazy var editButton = UIButton().then {
        $0.setImage(.image.studentEdit.image, for: .normal)
        $0.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
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
    
    @objc func editButtonTapped() {
        guard let window = UIApplication.shared.keyWindow,
              let rootViewController = window.rootViewController else { return }
        
        let userData = studentManagementVC.userList[indexPath.row]
        
        let bottomSheetVC = AuthorityBottomSheetVC()
        bottomSheetVC.userData = userData
        bottomSheetVC.userDataIndex = indexPath.row
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        rootViewController.present(bottomSheetVC, animated: false, completion: nil)
    }

    // MARK: - Configure
    func configureData(with userData: UserData) {
        if let imageURL = userData.profileImageURL, let url = URL(string: imageURL) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"))
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        } else {
            profileImageView.image = .image.gomsProfile.image
        }
        nameLabel.text = userData.name
        if userData.major == "SW_DEVELOP" {
            studentInfoLabel.text = "\(userData.grade)기 | SW개발"
        } else if userData.major == "SMART_IOT" {
            studentInfoLabel.text = "\(userData.grade)기 | IoT"
        } else {
            studentInfoLabel.text = "\(userData.grade)기 | AI"
        }
        
        if userData.authority == "ROLE_STUDENT_COUNCIL" {
            profileImageView.layer.borderColor = UIColor(red: 0.706, green: 0.525, blue: 0.976, alpha: 1).cgColor
            nameLabel.textColor = .color.gomsAdmin.color
        }
        
        if userData.isBlackList == true {
            profileImageView.layer.borderColor = UIColor(red: 0.895, green: 0.213, blue: 0.125, alpha: 1).cgColor
            nameLabel.textColor = .color.gomsNegative.color
        }
    }
    
    private func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentInfoLabel, divLine, editButton, bottomView].forEach { contentView.addSubview($0)}
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
        
        divLine.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.width.equalTo(1)
            $0.bottom.equalToSuperview().inset(18)
            $0.leading.equalTo(studentInfoLabel.snp.trailing).offset(4)
        }
        
        editButton.snp.makeConstraints {
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
