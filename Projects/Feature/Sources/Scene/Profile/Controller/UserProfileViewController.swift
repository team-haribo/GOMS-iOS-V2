//
//  UserProfileViewController.swift
//  Feature
//
//  Created by 서지완 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public class UserProfileViewController: BaseViewController {
    let userProfile = UIImageView().then {
        $0.image = .image.gomsProfile.image
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 32
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let userProfilepencil = UIImageView().then {
        $0.image = .image.gomsProfilePencil.image
    }
    
    let repasswordRight = UIImageView().then {
        $0.image = .image.gomsRightButton.image
    }
    
    let userName = UILabel().then {
        $0.text = "홍길동"
        $0.textColor = .white
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    let userGradeDepartment = UILabel().then {
        $0.text = "7기ㅣIoT"
        $0.textColor = .color.gomsSecondary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    let perceptionCount = UILabel().then {
        $0.text = "지각 횟수"
        $0.textColor = .color.gomsSecondary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    
    let perceptionNum = UILabel().then {
        $0.text = "11"
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    let perceptionText = UILabel().then {
        $0.text = "번"
        $0.textColor = .white
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    let line1View = UIView().then {
        $0.backgroundColor = .color.gomsTertiary.color
    }
    let line2View = UIView().then {
        $0.backgroundColor = .color.gomsTertiary.color
    }
    
    let repassword : UIButton = UIButton().then {
        $0.setTitle("비밀번호 재설정", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 16, weight: .semibold)
    }
    
    let pushcheckText = UILabel().then {
        $0.text = "외출제 푸시 알람"
        $0.textColor = .white
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    let pushcheckDescription = UILabel().then {
        $0.text = "외출할 시간이 될 떄마다 알려드려요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    let pushchecktoggleButton: UISwitch = UISwitch().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.onTintColor = .color.gomsPrimary.color
        $0.tintColor = .color.gomsTertiary.color
    }
    
    let cameranowonText = UILabel().then {
        $0.text = "카메라 바로 켜기"
        $0.textColor = .white
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    let cameranowonDescription = UILabel().then {
        $0.text = "앱을 실행하면 즉시 카메라가 켜져요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 12, weight: .regular)
    }
    
    let cameranowontoggleButton: UISwitch = UISwitch().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.onTintColor = .color.gomsPrimary.color
        $0.tintColor = .color.gomsTertiary.color
    }
    
    let lightmodeText = UILabel().then {
        $0.text = "라이트 모드 켜기"
        $0.textColor = .white
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    let lightmodeDescription = UILabel().then {
        $0.text = "앱 테마를 라이트 모드로 만들어요"
        $0.textColor = .color.gomsTertiary.color
        $0.font = .pretendard(size: 12, weight: .regular)
    }
    
    let lightmodetoggleButton: UISwitch = UISwitch().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.onTintColor = .color.gomsPrimary.color
        $0.tintColor = .color.gomsTertiary.color
    }
    
    let logoutButton = UIButton().then {
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 12
        $0.setTitle("로그아웃", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        let attributedTitle = NSAttributedString(string: "로그아웃", attributes: titleAttributes)
        alertController.setValue(attributedTitle, forKey: "attributedTitle")

        let messageAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 15)
        ]
        let attributedMessage = NSAttributedString(string: "로그아웃 하시겠습니까?", attributes: messageAttributes)
        alertController.setValue(attributedMessage, forKey: "attributedMessage")

        let confirmAction = UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] _ in
            print("로그아웃 버튼이 확인되었습니다.")
            self?.performLogout()
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        cancelAction.setValue(UIColor.color.gomsInformation.color, forKey: "titleTextColor")
        confirmAction.setValue(UIColor.color.gomsInformation.color, forKey: "titleTextColor")
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.present(alertController, animated: true, completion: nil)
    }


    // #로그아웃 버튼 클릭시 작동되는 함수
    func performLogout() {
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    override func addView() {
        [
            userProfile,
            userName,
            userGradeDepartment,
            perceptionCount,
            perceptionNum,
            perceptionText,
            userProfilepencil,
            pushcheckText,
            pushcheckDescription,
            pushchecktoggleButton,
            repassword,
            line1View,
            line2View,
            repasswordRight,
            cameranowonText,
            cameranowonDescription,
            cameranowontoggleButton,
            lightmodeText,
            lightmodeDescription,
            lightmodetoggleButton,
            logoutButton,
            
        ].forEach {
                view.addSubview($0)
            }
        }
    
    override func setLayout() {
        userProfile.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(64)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(136)
        }
        
        userProfilepencil.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom)
            $0.leading.equalTo(60)
        }
        
        userName.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(32)
            $0.leading.equalTo(userProfile.snp.trailing).inset(-16)
            $0.top.equalTo(userProfile.snp.top)
            
        }
        userGradeDepartment.snp.makeConstraints {
            $0.width.equalTo(58)
            $0.height.equalTo(28)
            $0.top.equalTo(userName.snp.bottom).offset(4)
            $0.leading.equalTo(userName.snp.leading)
            
            
        }
        
        perceptionCount.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(28)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(userName.snp.top).inset(0)
        }
        
        perceptionNum.snp.makeConstraints {
            $0.width.equalTo(18)
            $0.height.equalTo(32)
            $0.trailing.equalTo(perceptionText.snp.leading)
            $0.top.equalTo(perceptionCount.snp.bottom).offset(4)
        }
        
        perceptionText.snp.makeConstraints {
            $0.width.equalTo(17)
            $0.height.equalTo(32)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(perceptionCount.snp.bottom).offset(4)
        }
        line1View.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalTo(userProfile.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        repassword.snp.makeConstraints {
            $0.width.equalTo(117)
            $0.height.equalTo(28)
            $0.leading.equalTo(userProfile.snp.leading)
            $0.top.equalTo(line1View.snp.top).offset(22)
        }
        
        line2View.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(repassword.snp.bottom).offset(22)
        }
        
        repasswordRight.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(repassword.snp.top)
        }
        
        pushcheckText.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(28)
            $0.leading.equalTo(repassword.snp.leading).offset(8)
            $0.top.equalTo(line2View.snp.top).offset(25)
        }
        pushcheckDescription.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(20)
            $0.leading.equalTo(pushcheckText.snp.leading)
            $0.top.equalTo(pushcheckText.snp.bottom)
        }
        pushchecktoggleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(line2View.snp.top).offset(32)
        }
        
        cameranowonText.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(28)
            $0.leading.equalTo(pushcheckText.snp.leading)
            $0.top.equalTo(pushcheckDescription.snp.bottom).offset(32)
        }
        cameranowonDescription.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(20)
            $0.top.equalTo(cameranowonText.snp.bottom)
            $0.leading.equalTo(pushcheckText.snp.leading)
        }
        
        cameranowontoggleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(pushchecktoggleButton.snp.bottom).offset(48)
        }
        
        lightmodeText.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(28)
            $0.leading.equalTo(pushcheckText.snp.leading)
            $0.top.equalTo(cameranowonDescription.snp.bottom).offset(32)
        }
        lightmodeDescription.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(20)
            $0.top.equalTo(lightmodeText.snp.bottom)
            $0.leading.equalTo(pushcheckText.snp.leading)
        }
        
        lightmodetoggleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(cameranowontoggleButton.snp.bottom).offset(48)
        }
        logoutButton.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
            
        }
    }
}

