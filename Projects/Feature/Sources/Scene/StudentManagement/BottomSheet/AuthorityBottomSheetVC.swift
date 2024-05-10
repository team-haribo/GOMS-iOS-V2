//
//  AuthorityBottomSheetVC.swift
//  Feature
//
//  Created by 새미 on 5/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class AuthorityBottomSheetVC: BaseViewController {

    // MARK: - Properties
    private let bottomSheetView = UIView().then {
        $0.setDynamicBackgroundColor(darkModeColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), lightModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "유저 권한 변경"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 19, weight: .bold)
    }
    
    private lazy var closeButton = UIButton().then {
        $0.setBackgroundImage(.image.cancelButton.image, for: .normal)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private let prohibitionOutingTitle = UILabel().then {
        $0.text = "외출금지"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    private let prohibitionOutingLabel = UILabel().then {
        $0.text = "이 학생은 외출을 할 수 없어요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 12, weight: .regular)
    }
    
    let prohibitionOutingSwitch = UISwitch().then {
        $0.onTintColor = .color.gomsAdmin.color
    }
    
    private let authorityTitle = UILabel().then {
        $0.text = "학생회 권한 부여"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    private let authorityLabel = UILabel().then {
        $0.text = "이 학생은 학생회에요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 12, weight: .regular)
    }
    
    let authoritySwitch = UISwitch().then {
        $0.onTintColor = .color.gomsAdmin.color
    }

    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Add View
    override func addView() {
        [titleLabel, closeButton, prohibitionOutingTitle, prohibitionOutingLabel, prohibitionOutingSwitch, authorityTitle, authorityLabel, authoritySwitch].forEach { self.bottomSheetView.addSubview($0) }
        view.addSubview(bottomSheetView)
    }

    // MARK: Layout
    override func setLayout() {
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.height * 0.34)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
            $0.top.equalToSuperview().inset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.06)
            $0.top.equalToSuperview().inset(20)
            $0.width.height.equalTo(24)
        }
        
        prohibitionOutingTitle.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
        }
        
        prohibitionOutingLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(20)
            $0.top.equalTo(prohibitionOutingTitle.snp.bottom)
        }
        
        prohibitionOutingSwitch.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(closeButton.snp.bottom).offset(44)
        }
        
        authorityTitle.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.top.equalTo(prohibitionOutingLabel.snp.bottom).offset(32)
        }
        
        authorityLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(20)
            $0.top.equalTo(authorityTitle.snp.bottom)
        }
        
        authoritySwitch.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(prohibitionOutingSwitch.snp.bottom).offset(48)
        }
    }
}
