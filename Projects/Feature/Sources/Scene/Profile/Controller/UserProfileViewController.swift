//
//  UserProfileViewController.swift
//  Feature
//
//  Created by 서지완 on 3/4/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import Combine
import Moya

public class UserProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    let viewModel = ProfileViewModel()
    var cancellables = Set<AnyCancellable>()
    
    let userProfile = UIImageView().then {
        $0.image = .image.gomsBasicProfile.image
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 32
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let userProfilepencil = UIButton().then {
        $0.setImage(.image.gomsProfilePencil.image, for: .normal)
        $0.addTarget(self, action: #selector(ShowActionSheetProfilImageChange), for: .touchUpInside)
    }
    
    let repasswordRight = UIButton().then {
        $0.setImage(.image.gomsRightButton.image, for: .normal)
        $0.addTarget(self, action: #selector(passwordResetPage), for: .touchUpInside)
    }
    
    let userName = UILabel().then {
        $0.text = ""
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    let userGradeDepartment = UILabel().then {
        $0.text = ""
        $0.textColor = .color.gomsSecondary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    let perceptionCount = UILabel().then {
        $0.text = "지각 횟수"
        $0.textColor = .color.gomsSecondary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    
    let perceptionNum = UILabel().then {
        $0.text = "\(0)"
        $0.textColor = .color.gomsNegative.color
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    let perceptionText = UILabel().then {
        $0.text = "번"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 19, weight: .semibold)
    }
    
    let line1View = UIView().then {
        $0.backgroundColor = .color.gomsDivider.color
    }
    let line2View = UIView().then {
        $0.backgroundColor = .color.gomsDivider.color
    }
    
    let repassword : UIButton = UIButton().then {
        $0.setTitle("비밀번호 재설정", for: .normal)
        $0.setTitleColor(.color.gomsTextDefault.color, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(passwordResetPage), for: .touchUpInside)
    }
    
    let themeChangText = UILabel().then {
        $0.text = "앱 테마 설정"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    let themeChangRec = UIButton().then {
        $0.backgroundColor = .color.gomsTheme.color
        $0.addTarget(self, action: #selector(ShowActionSheetClick), for: .touchUpInside)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsCoverDivider.color.cgColor
    }
    
    let themeChangLine = UIButton().then {
        $0.backgroundColor = .color.gomsDivider.color
        $0.layer.cornerRadius = 12
    }
    
    let themesettingText = UILabel().then {
        $0.text = "시스템 테마 설정"
        $0.textColor = .color.gomsSecondary.color
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    let themesettingImg = UIImageView().then {
        $0.image = .image.gomsBottomButton.image
    }
    
    let pushcheckText = UILabel().then {
        $0.text = "외출제 푸시 알람"
        $0.textColor = .color.gomsTextDefault.color
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
        $0.textColor = .color.gomsTextDefault.color
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
        $0.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        $0.isOn = false
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
    
    let borderView = UIView().then() {
        $0.backgroundColor = .color.gomsDivider.color
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {        
        let QRState = sender.isOn
        print("QR카메라 바로켜기: \(sender.isOn ? "On" : "Off")")
        print(QRState)
        UserDefaults.standard.set(sender.isOn, forKey: "isSwitchOn")
        
        let defaults = UserDefaults.standard
            
            let isSwitchOn = defaults.bool(forKey: "isSwitchOn")
        print("테스트: \(isSwitchOn)")
    }
    
    @IBAction func ShowActionSheetClick(_ sender: UIButton) {
        updateImage(isActionSheetShowing: true)
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "다크(기본)", style: .default, handler: { [weak self] (ACTION:UIAlertAction) in
            print("다크(default) 모드로 변경")
            if let window = UIApplication.shared.windows.first {
                window.overrideUserInterfaceStyle = .dark
                self?.themesettingText.text = "다크(기본)"
                
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "라이트", style: .default, handler: { [weak self] (ACTION:UIAlertAction) in
            print("라이트(Light) 모드로 변경")
            if let window = UIApplication.shared.windows.first {
                window.overrideUserInterfaceStyle = .light
                self?.themesettingText.text = "라이트"
                
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "시스템 테마 설정", style: .default, handler: { [weak self] (ACTION:UIAlertAction) in
            print("시스템 기본(basics) 테마로 변경")
            if let window = UIApplication.shared.windows.first {
                window.overrideUserInterfaceStyle = .unspecified
                self?.themesettingText.text = "시스템 테마 설정"
                
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { [weak self] _ in
            self?.updateImage(isActionSheetShowing: false)
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    @objc func logoutButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.color.gomsTextDefault.color,
            .font: UIFont.pretendard(size: 17, weight: .semibold)
        ]
        let attributedTitle = NSAttributedString(string: "로그아웃\n", attributes: titleAttributes)
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        
        let messageAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.color.gomsTextDefault.color,
            .font: UIFont.pretendard(size: 13, weight: .regular)
        ]
        let attributedMessage = NSAttributedString(string: "로그아웃 하시겠습니까?", attributes: messageAttributes)
        alertController.setValue(attributedMessage, forKey: "attributedMessage")
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] _ in
            let viewModel = ProfileViewModel()
            viewModel.ProfileLogout(presentingViewController: SignInViewController())
            self?.performLogout()
        }
        alertController.addAction(confirmAction)
        
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .color.gomsTheme.color
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func passwordResetPage() {
        #warning("비밀번호 재설정 뷰 연결")
    }
    
    func performLogout() {
        let alertController = UIAlertController(title: "로그아웃", message: "로그아웃하시겠습니까?", preferredStyle: .alert)
    }
    
    @objc func updateImage(isActionSheetShowing: Bool) {
        if isActionSheetShowing {
            themesettingImg.image = UIImage.image.gomsTopButton.image
        } else {
            themesettingImg.image = UIImage.image.gomsBottomButton.image
        }
    }
    
    @objc func themaChang() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let nextMode: UIUserInterfaceStyle = isDarkMode ? .light : .dark
        overrideUserInterfaceStyle = nextMode
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func ShowActionSheetProfilImageChange(_ sender: UIButton) {
        updateImage(isActionSheetShowing: true)
        let actionSheet = UIAlertController(title: "프로필 사진 선택", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "갤러리에서 선택", style: .default, handler: { [weak self] (ACTION:UIAlertAction) in
            self?.presentGallery()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "기본 프로필 사용", style: .default, handler: { [weak self] (ACTION:UIAlertAction) in
            self?.userProfile.image = .image.gomsBasicProfile.image
            let viewModel = ProfileViewModel()
                viewModel.deleteProfileImage()
            
        }))

        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { [weak self] _ in
            self?.updateImage(isActionSheetShowing: false)
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func presentGallery() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePickerController.sourceType = .photoLibrary
                present(imagePickerController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "알림", message: "사용할 수 있는 앨범이 없습니다.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage,
               let imageData = pickedImage.jpegData(compressionQuality: 0.8) {
                let providerserve = MoyaProvider<ProfileImageServices>()
                providerserve.request(.submit(authorization: "", imageData: imageData)) { result in
                    switch result {
                    case let .success(response):
                        print(response)
                        DispatchQueue.main.async { [weak self] in
                            self?.userProfile.image = pickedImage
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
            }
            dismiss(animated: true, completion: nil)
        }
    
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadProfileInfo()
        
        viewModel.$profileInfo.sink { [weak self] profileInfo in
            guard let profileInfo = profileInfo else { return }
            DispatchQueue.main.async {
                self?.userName.text = profileInfo.name
                self?.perceptionNum.text = String(describing: profileInfo.lateCount)
                
                let majorText: String
                switch profileInfo.major {
                case "SW_DEVELOP":
                    majorText = "SW"
                case "SMART_IOT":
                    majorText = "IoT"
                default:
                    majorText = "AI"
                }
                let finalText = "\(profileInfo.grade)기ㅣ\(majorText)"
                let profileUrlString = profileInfo.profileUrl ?? ""

                if let profileUrl = URL(string: profileUrlString) {
                    URLSession.shared.dataTask(with: profileUrl) { data, response, error in
                        if let error = error {
                            print("이미지 데이터를 가져오는 중 에러 발생: \(error)")
                            return
                        }
                        
                        if let imageData = data, let profileImage = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self?.userProfile.image = profileImage
                            }
                        }
                    }.resume()
                }

                let uploadimage = profileInfo.profileUrl
                self?.userGradeDepartment.text = finalText
            }
        }
        .store(in: &cancellables)

        
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
        
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        imagePickerController.delegate = self
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
            logoutButton,
            themeChangText,
            themeChangRec,
            themesettingImg,
            themesettingText,
            themeChangLine
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
            $0.top.equalTo(userGradeDepartment.snp.top)
            $0.trailing.equalTo(userProfile.snp.trailing)
        }

        userName.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(32)
            $0.leading.equalTo(userProfile.snp.trailing).inset(-16)
            $0.top.equalTo(userProfile.snp.top)
            
        }
        
        userGradeDepartment.snp.makeConstraints {
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
        
        themeChangText.snp.makeConstraints {
            $0.width.equalTo(93)
            $0.height.equalTo(28)
            $0.top.equalTo(line2View.snp.top).offset(24)
            $0.leading.equalTo(repassword.snp.leading).offset(8)
        }

        themeChangRec.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(64)
            $0.top.equalTo(themeChangText.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        themesettingText.snp.makeConstraints {
            $0.width.equalTo(106)
            $0.height.equalTo(28)
            $0.top.equalTo(themeChangRec.snp.top).offset(18)
            $0.leading.equalTo(themeChangRec.snp.leading).offset(12)
        }
        
        themesettingImg.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            $0.top.equalTo(themeChangRec.snp.top).offset(20)
            $0.trailing.equalToSuperview().inset(32)
        }
        
        repasswordRight.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(repassword.snp.top)
        }
        
        pushcheckText.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(28)
            $0.leading.equalTo(repassword.snp.leading).offset(8)
            $0.top.equalTo(themeChangRec.snp.bottom).offset(25)
        }
        
        pushcheckDescription.snp.makeConstraints {
            $0.width.equalTo(184)
            $0.height.equalTo(20)
            $0.leading.equalTo(pushcheckText.snp.leading)
            $0.top.equalTo(pushcheckText.snp.bottom)
        }
        
        pushchecktoggleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(themeChangRec.snp.bottom).offset(25)
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

        logoutButton.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cameranowonDescription.snp.top).offset(108)
            
        }
    }
}


