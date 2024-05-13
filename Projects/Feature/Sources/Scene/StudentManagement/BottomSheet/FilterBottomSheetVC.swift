//
//  FilterBottomSheetVC.swift
//  Feature
//
//  Created by 새미 on 5/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class FilterBottomSheetVC: BaseViewController {
    
    // MARK: - Properties
    private let viewModel = StudentManagementViewModel()
    
    private let dimmedView = UIView().then {
        $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
    }
    
    private let bottomSheetView = UIView().then {
        $0.setDynamicBackgroundColor(darkModeColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), lightModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
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
    
    private lazy var studentButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "학생").then {
        $0.addTarget(self, action: #selector(roleTapped), for: .touchUpInside)
    }
    
    private lazy var adminButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "학생회").then {
        $0.addTarget(self, action: #selector(roleTapped), for: .touchUpInside)
    }
    
    private lazy var blackListButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "외출금지").then {
        $0.addTarget(self, action: #selector(roleTapped), for: .touchUpInside)
    }
    
    private let gradeLabel = UILabel().then {
        $0.font = .pretendard(size: 19, weight: .semibold)
        $0.text = "학년"
        $0.textColor = .color.gomsTextDefault.color
    }
    
    private lazy var grade1Button = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "1학년").then {
        $0.addTarget(self, action: #selector(gradeButtonTappped), for: .touchUpInside)
    }
    
    private lazy var grade2Button = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "2학년").then {
        $0.addTarget(self, action: #selector(gradeButtonTappped), for: .touchUpInside)
    }
    
    private lazy var grade3Button = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "3학년").then {
        $0.addTarget(self, action: #selector(gradeButtonTappped), for: .touchUpInside)
    }
    
    private let genderLabel = UILabel().then {
        $0.font = .pretendard(size: 19, weight: .semibold)
        $0.text = "성별"
        $0.textColor = .color.gomsTextDefault.color
    }
    
    private lazy var manButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "남성").then {
        $0.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
    }
    
    private lazy var womanButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "여성").then {
        $0.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
    }
    
    private let majorLabel = UILabel().then {
        $0.font = .pretendard(size: 19, weight: .semibold)
        $0.text = "학과"
        $0.textColor = .color.gomsTextDefault.color
    }
    
    private lazy var swButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "SW").then {
        $0.addTarget(self, action: #selector(majorButtonTapped), for: .touchUpInside)
    }
    
    private lazy var iotButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "IoT").then {
        $0.addTarget(self, action: #selector(majorButtonTapped), for: .touchUpInside)
    }
    
    private lazy var aiButton = BottomSheetButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "AI").then {
        $0.addTarget(self, action: #selector(majorButtonTapped), for: .touchUpInside)
    }
    
    private lazy var resetButton = ResetButton().then {
        $0.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Selectors
    @objc func closeButtonTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func roleTapped(sender: BottomSheetButton) {
        guard let role = sender.title(for: .normal) else { return }
        
        switch role {
        case "학생":
            print("학생 버튼이 선택되었습니다.")
        case "학생회":
            print("학생회 버튼이 선택되었습니다.")
        case "외출금지":
            print("외출금지 버튼이 선택되었습니다.")
        default:
            break
        }
    }
    
    @objc func gradeButtonTappped(sender: BottomSheetButton) {
        guard let grade = sender.title(for: .normal) else { return }
        
        switch grade {
        case "1학년":
            viewModel.setupGrade(grade: 1)
        case "2학년":
            viewModel.setupGrade(grade: 2)
        case "3학년":
            viewModel.setupGrade(grade: 3)
        default:
            break
        }
    }
    
    @objc func genderButtonTapped(sender: BottomSheetButton) {
        guard let gender = sender.title(for: .normal) else { return }
        
        switch gender {
        case "남성":
            viewModel.setupGender(gender: "MAN")
        case "여성":
            viewModel.setupGender(gender: "WOMAN")
        default:
            break
        }
    }

    @objc func majorButtonTapped(sender: BottomSheetButton) {
        guard let major = sender.title(for: .normal) else { return }
 
        
    }
    
    @objc func resetButtonTapped() {
        
    }
    
    // MARK: - Add View
    override func addView() {
        [titleLabel, closeButton, roleLabel, studentButton, adminButton, blackListButton, gradeLabel, grade1Button, grade2Button, grade3Button, genderLabel, manButton, womanButton, majorLabel, swButton, iotButton, aiButton, resetButton].forEach { self.bottomSheetView.addSubview($0) }
        dimmedView.addSubview(bottomSheetView)
        view.addSubview(dimmedView)
    }
    
    // MARK:  - Layout
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
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
        
        adminButton.snp.makeConstraints {
            $0.width.equalTo(bounds.width * 0.27)
            $0.top.equalTo(roleLabel.snp.bottom).offset(8)
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
        }
        
        blackListButton.snp.makeConstraints {
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
