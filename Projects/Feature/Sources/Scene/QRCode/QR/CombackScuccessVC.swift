//
//  CombackScuccessVC.swift
//  Feature
//
//  Created by 새미 on 7/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class CombackScuccessVC: BaseViewController {

    private let image = UIImageView().then {
        $0.image = .image.outingCheck.image
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 24, weight: .bold)
        $0.text = "복귀에 성공했어요!"
    }
    
    private let mainLabel = UILabel().then {
        $0.textColor = .color.gomsSecondary.color
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.text = "제 때 복귀하셨군요!\n다음 외출제 때 또 만나요!"
        $0.setLineSpacing(spacing: 3)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private lazy var checkButton = GOMSButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "확인").then {
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }

    // MARK: - Life Cycel
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Selector
    @objc func checkButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Configure Navigation
    override func configNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Add View
    override func addView() {
        [image, titleLabel, mainLabel, checkButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(150)
            $0.top.equalTo(bounds.height * 0.3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(image.snp.bottom).offset(16)
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.height.equalTo(56)
        }
        
        checkButton.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-bounds.height * 0.07)
        }
    }
}
