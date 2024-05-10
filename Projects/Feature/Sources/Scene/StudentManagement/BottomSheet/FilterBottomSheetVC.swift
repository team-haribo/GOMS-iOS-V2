//
//  FilterBottomSheetVC.swift
//  Feature
//
//  Created by 새미 on 5/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class FilterBottomSheetVC: BaseViewController {
    
    // MARK: - Properties
    private let bottomSheetView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "필터"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 19, weight: .bold)
    }
    
    private lazy var closeButton = UIButton().then {
        $0.setBackgroundImage(.image.cancelButton.image, for: .normal)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private let roleLabel = UILabel().then {
        $0.font = .pretendard(size: 19, weight: .semibold)
        $0.text = "역할"
        $0.textColor = .color.gomsTextDefault.color
    }
    
    private let studentButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "학생")
    private let studentCouncilButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "학생회")
    private let prohibitionOutingButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "외출금지")
    
    
    private let gradeLabel = UILabel().then {
        $0.font = .pretendard(size: 19, weight: .semibold)
        $0.text = "학년"
        $0.textColor = .color.gomsTextDefault.color
    }
    
    private let grade1Button = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "1학년")
    private let grade2Button = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "2한년")
    private let grade3Button = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "3학년")
    
    private let genderLabel = UILabel().then {
        $0.font = .pretendard(size: 19, weight: .semibold)
        $0.text = "성별"
        $0.textColor = .color.gomsTextDefault.color
    }
    
    private let manButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "남성")
    private let womanButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "여성")
    
    private let majorLabel = UILabel().then {
        $0.font = .pretendard(size: 19, weight: .semibold)
        $0.text = "학과"
        $0.textColor = .color.gomsTextDefault.color
    }
    
    private let swButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "SW")
    private let iotButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "IoT")
    private let aiButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "AI")
    
    private let resetButton = ResetButton()
    
    // MARK: - Life Cycel
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Add View
    override func addView() {
        [titleLabel, closeButton, roleLabel, studentButton, studentCouncilButton, prohibitionOutingButton, gradeLabel, grade1Button, grade2Button, grade3Button, genderLabel, manButton, womanButton, majorLabel, swButton, iotButton, aiButton, resetButton].forEach { self.bottomSheetView.addSubview($0) }
        view.addSubview(bottomSheetView)
    }
    
    // MARK:  - Layout
    override func setLayout() {
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.height * 0.8)
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
        }
        
        roleLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        studentButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.width.equalTo(bounds.width * 0.27)
            $0.height.equalTo(56)
            $0.top.equalTo(roleLabel.snp.bottom).offset(8)
        }
        
        studentCouncilButton.snp.makeConstraints {
            $0.width.equalTo(bounds.width * 0.27)
            $0.top.equalTo(roleLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
        }
        
        prohibitionOutingButton.snp.makeConstraints {
            $0.width.equalTo(bounds.width * 0.27)
            $0.top.equalTo(roleLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.trailing.equalTo(-bounds.width * 0.05)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
            $0.top.equalTo(studentButton.snp.bottom).offset(16)
        }
        
        grade1Button.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.width.equalTo(bounds.width * 0.27)
            $0.height.equalTo(56)
            $0.top.equalTo(gradeLabel.snp.bottom).offset(8)
        }
        
        grade2Button.snp.makeConstraints {
            $0.width.equalTo(bounds.width * 0.27)
            $0.top.equalTo(gradeLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
        }
        
        grade3Button.snp.makeConstraints {
            $0.width.equalTo(bounds.width * 0.27)
            $0.top.equalTo(gradeLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.trailing.equalTo(-bounds.width * 0.05)
        }
        
        genderLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
            $0.top.equalTo(grade1Button.snp.bottom).offset(16)
        }
        
        manButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.top.equalTo(genderLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.width.equalTo(bounds.width * 0.42)
        }
        
        womanButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(56)
            $0.width.equalTo(bounds.width * 0.42)
        }
        
        majorLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
            $0.top.equalTo(manButton.snp.bottom).offset(16)
        }
        
        swButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.width.equalTo(bounds.width * 0.27)
            $0.height.equalTo(56)
            $0.top.equalTo(majorLabel.snp.bottom).offset(8)
        }
        
        iotButton.snp.makeConstraints {
            $0.width.equalTo(bounds.width * 0.27)
            $0.top.equalTo(majorLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
        }
        
        aiButton.snp.makeConstraints {
            $0.width.equalTo(bounds.width * 0.27)
            $0.top.equalTo(majorLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.trailing.equalTo(-bounds.width * 0.05)
        }
        
        resetButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(56)
            $0.bottom.equalTo(-bounds.height * 0.07)
        }
    }
}
