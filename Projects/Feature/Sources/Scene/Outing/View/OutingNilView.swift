//
//  OutingNilView.swift
//  Feature
//
//  Created by 새미 on 4/24/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then

class OutingNilView: UIView {
    
    private let coffeeIcon = UIImageView()
    
    private let mainLabel = UILabel().then {
        $0.text = "텅 비어있네요... 다들 바쁜가 봐요!"
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 14, weight: .semibold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        coffeeIcon.image = .image.grayCoffee.image
        
        [coffeeIcon, mainLabel].forEach { self.addSubview($0) }
        
        coffeeIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalTo(coffeeIcon.snp.trailing).offset(4)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
}
