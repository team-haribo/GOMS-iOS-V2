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
    var userList: [UserData] = []
    
    var userData: UserData?
    var userDataIndex: Int?
    
    private let viewModel = StudentManagementViewModel()
    
    var studentManagementVC: StudentManagementViewController
            
    init(studentManagementVC: StudentManagementViewController) {
        self.studentManagementVC = studentManagementVC
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
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

    private let forceOutingTitle = UILabel().then {
        $0.text = "강제외출"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 16, weight: .semibold)
    }

    private let forceOutingLabel = UILabel().then {
        $0.text = "이 학생은 현재 외출중이에요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 12, weight: .regular)
    }

    private let blackListTitle = UILabel().then {
        $0.text = "외출금지"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    private let blackListLabel = UILabel().then {
        $0.text = "이 학생은 외출을 할 수 없어요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 12, weight: .regular)
    }

    private lazy var forceOutingButton = UIButton().then {
        $0.setBackgroundImage(.image.forceOutingIcon.image, for: .normal)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    lazy var blackListSwitch = UISwitch().then {
        $0.onTintColor = .color.gomsAdmin.color
        $0.addTarget(self, action: #selector(blackListSwitchValueChanged), for: .valueChanged)
    }
    
    private let adminTitle = UILabel().then {
        $0.text = "학생회 권한 부여"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    private let adminLabel = UILabel().then {
        $0.text = "이 학생은 학생회에요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 12, weight: .regular)
    }
    
    lazy var adminSwitch = UISwitch().then {
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
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.studentManagementVC.configureRefreshControl()
    }
    
    func setupSwitch() {
        if let userData = userData, userData.isBlackList {
            blackListSwitch.isOn = true
        } else {
            blackListSwitch.isOn = false
        }
        
        if let userData = userData, userData.authority == Authority.admin.rawValue {
            adminSwitch.isOn = true
        } else {
            adminSwitch.isOn = false
        }
    }
    
    func updateUserList(_ newList: [UserData]) {
        self.studentManagementVC.userList = newList
        DispatchQueue.main.async {
            self.studentManagementVC.studentCollectionView.reloadData()
        }
    }
    
    @objc func closeButtonTapped() {
        self.studentManagementVC.studentCollectionView.reloadData()
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func blackListSwitchValueChanged(_ sender: UISwitch) {
        guard let userData = userData else { return }
            
            if sender.isOn {
                viewModel.blackList(user: userData) { newList in
                    self.updateUserList(newList)
                    self.studentManagementVC.searchController.searchBar.text = ""
                }
            } else {
                viewModel.cancelBlackList(user: userData) { newList in
                    self.updateUserList(newList)
                    self.studentManagementVC.searchController.searchBar.text = ""
                }
            }
    }
  
    @objc func authoritySwitchValueChanged(_ sender: UISwitch) {
        guard let userData = userData else { return }
            
        viewModel.changeAuthority(user: userData) { newList in
            self.updateUserList(newList)
            self.studentManagementVC.searchController.searchBar.text = ""
        }
    }
    
    // MARK: - Add View
    override func addView() {
        [titleLabel, closeButton, forceOutingTitle, forceOutingLabel, forceOutingButton, blackListTitle, blackListLabel, blackListSwitch, adminTitle, adminLabel, adminSwitch].forEach { self.bottomSheetView.addSubview($0) }
        dimmedView.addSubview(bottomSheetView)
        view.addSubview(dimmedView)
    }

    // MARK: Layout
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        bottomSheetView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.height * (userData?.isOuting == true ? 0.34 : 0.43))
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

        if userData?.isOuting == false {
            forceOutingTitle.snp.makeConstraints {
                $0.height.equalTo(28)
                $0.leading.equalTo(bounds.width * 0.05)
                $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            }

            forceOutingLabel.snp.makeConstraints {
                $0.leading.equalTo(bounds.width * 0.05)
                $0.height.equalTo(20)
                $0.top.equalTo(forceOutingTitle.snp.bottom)
            }

            forceOutingButton.snp.makeConstraints {
                $0.trailing.equalTo(-bounds.width * 0.07)
                $0.top.equalTo(closeButton.snp.bottom).offset(44)
            }
        }

        blackListTitle.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.top.equalTo((userData!.isOuting ? titleLabel : forceOutingLabel).snp.bottom).offset(32)
        }
        
        blackListLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(20)
            $0.top.equalTo(blackListTitle.snp.bottom)
        }
        
        blackListSwitch.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo((userData!.isOuting ? closeButton : forceOutingButton).snp.bottom)
                .offset(userData!.isOuting ? 44 : 52)

        }
        
        adminTitle.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.top.equalTo(blackListLabel.snp.bottom).offset(32)
        }
        
        adminLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(20)
            $0.top.equalTo(adminTitle.snp.bottom)
        }
        
        adminSwitch.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(blackListSwitch.snp.bottom).offset(48)
        }
    }
}
