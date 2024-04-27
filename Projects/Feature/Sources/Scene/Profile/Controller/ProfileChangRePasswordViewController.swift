//
//  ProfileChangRePasswordViewController.swift
//  Feature
//
//  Created by 서지완 on 4/25/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import Combine
import Moya
import SnapKit

public class ProfileChangRePasswordViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let viewModel = AuthViewModel()
    
    let navigationTitle = UILabel().then {
        $0.text = "비밀번호 재설정"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 29, weight: .bold)
    }
    
    let passwordTextField = GOMSTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: "현재 비밀번호")
    
    private lazy var doneButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "다음으로").then {
        $0.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    private var doneButtonBottomConstraint: Constraint?
    private var textFieldBottomConstraint: Constraint?
    
    @objc func doneButtonTapped() {
        viewModel.newPassword {  success in
            if success {
                let alert = UIAlertController(title: "재설정 완료", message: "비밀번호가 재설정되었습니다.\n로그인 화면으로 돌아갑니다.", preferredStyle: .alert)
                
                let check = UIAlertAction(title: "확인", style: .default) { action in
                    let loginVC = SignInViewController()
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
                alert.addAction(check)
                self.present(alert, animated: true)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func addView() {
        [
            navigationTitle,
            passwordTextField,
            doneButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        navigationTitle.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(183)
            $0.top.equalToSuperview().inset(bounds.height * 0.09) // 9% 상대적 위치
            $0.leading.equalToSuperview().inset(bounds.width * 0.05) // 5% 상대적 위치
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.width.equalTo(335)
            
            textFieldBottomConstraint = $0.bottom.equalToSuperview().inset(bounds.height * 0.47).constraint // 21% 상대적 위치
            $0.leading.equalToSuperview().inset(bounds.width * 0.05) // 5% 상대적 위치
            $0.trailing.equalToSuperview().inset(bounds.width * 0.05) // 5% 상대적 위치
        }
        
        doneButton.snp.makeConstraints {
            doneButtonBottomConstraint = $0.bottom.equalToSuperview().inset(view.bounds.height * 0.17).constraint // 5.7% 상대적 위치
            $0.height.equalTo(48)
            $0.width.equalTo(335)
            $0.leading.equalToSuperview().inset(bounds.width * 0.05) // 5% 상대적 위치
            $0.trailing.equalToSuperview().inset(bounds.width * 0.05) // 5% 상대적 위치
        }
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.doneButtonBottomConstraint?.update(inset: keyboardHeight + 13)
            self.textFieldBottomConstraint?.update(inset: keyboardHeight + (self.bounds.height * 0.2))
            
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.doneButtonBottomConstraint?.update(inset: self.bounds.height * 0.057)
            self.textFieldBottomConstraint?.update(inset: self.bounds.height * 0.45)
            
            self.view.layoutIfNeeded()
        }
    }
}
