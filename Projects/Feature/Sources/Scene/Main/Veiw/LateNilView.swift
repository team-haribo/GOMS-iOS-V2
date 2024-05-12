//
//  LateNilView.swift
//  Feature
//
//  Created by 새미 on 5/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class LateNilView: UIView {

    // MARK: - Properties
    private let icon = UIImageView().then {
        $0.image = .image.fire.image
    }
    
    private let mainLabel = UILabel().then {
        $0.text = "이번 주 지각자가 없네요! 축하해요!"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 14, weight: .semibold)
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
    
    private func configureUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.backgroundColor = .color.gomsCardBackgroundColor.color
    }
    
    private func addView() {
        [icon, mainLabel].forEach { self.addSubview($0) }
    }
    
    private func setLayout() {
        icon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.height.width.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(icon.snp.trailing).offset(4)
        }
    }
}
