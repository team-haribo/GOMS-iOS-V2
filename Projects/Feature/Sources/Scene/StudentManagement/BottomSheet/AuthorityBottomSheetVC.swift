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
    var userData: UserData?
    var userDataIndex: Int?
    
    private let viewModel = StudentManagementViewModel()
    let studentManagementVC = StudentManagementViewController()
    
    private let dimmedView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).withAlphaComponent(0.6)
    }
    
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
    
    lazy var prohibitionOutingSwitch = UISwitch().then {
        $0.onTintColor = .color.gomsAdmin.color
        $0.addTarget(self, action: #selector(blackListSwitchValueChanged), for: .valueChanged)
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
    
    lazy var authoritySwitch = UISwitch().then {
        $0.onTintColor = .color.gomsAdmin.color
        $0.addTarget(self, action: #selector(authoritySwitchValueChanged(_:)), for: .valueChanged)
    }

    // MARK: - Life Cycel
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSwitch()
    }
    
    func setupSwitch() {
        if let userData = userData, userData.isBlackList {
            prohibitionOutingSwitch.isOn = true
        } else {
            prohibitionOutingSwitch.isOn = false
        }
        
        if let userData = userData, userData.authority == "ROLE_STUDENT_COUNCIL" {
            authoritySwitch.isOn = true
        } else {
            authoritySwitch.isOn = false
        }
    }
    
    @objc func closeButtonTapped() {
        self.studentManagementVC.studentCollectionView.reloadData()
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func blackListSwitchValueChanged(_ sender: UISwitch) {
        guard let userData = userData, let index = userDataIndex else { return }
        
        if sender.isOn {
            viewModel.blackList(index: index) {
                print("blackList")
                let cell = StudentCollectionViewCell()
                let userData = userData
    
                cell.configureData(with: userData)
                self.setupSwitch()
                self.studentManagementVC.studentCollectionView.reloadData()
            }
        } else {
            viewModel.cancelBlackList(index: index) {
                print("Delete blackList")
                let cell = StudentCollectionViewCell()
                let userData = userData
    
                cell.configureData(with: userData)
                self.setupSwitch()
                self.studentManagementVC.studentCollectionView.reloadData()
            }
        }
    }
  
    @objc func authoritySwitchValueChanged(_ sender: UISwitch) {
        guard let userData = userData, let index = userDataIndex else { return }
        
        if sender.isOn {
            viewModel.changeAuthority(index: index) {
                print("권한 수정")
                let cell = StudentCollectionViewCell()
                let userData = userData
    
                cell.configureData(with: userData)
                self.setupSwitch()
                self.studentManagementVC.studentCollectionView.reloadData()
            }
        } else {
            viewModel.changeAuthority(index: index) {
                print("권한 수정")
                let cell = StudentCollectionViewCell()
                let userData = userData
    
                cell.configureData(with: userData)
                self.setupSwitch()
                self.studentManagementVC.studentCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - Add View
    override func addView() {
        [titleLabel, closeButton, prohibitionOutingTitle, prohibitionOutingLabel, prohibitionOutingSwitch, authorityTitle, authorityLabel, authoritySwitch].forEach { self.bottomSheetView.addSubview($0) }
        dimmedView.addSubview(bottomSheetView)
        view.addSubview(dimmedView)
    }

    // MARK: Layout
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
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
