//
//  AdminQRButton.swift
//  Feature
//
//  Created by 새미 on 2/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit

final class AdminQRButton: UIButton {
    
    private let QRFrame = UIImageView()
    private let QRIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [QRFrame, QRIcon].forEach { self.addSubview($0) }
        
        QRFrame.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.centerX.centerY.equalToSuperview()
        }
        
        QRIcon.snp.makeConstraints {
            $0.height.width.equalTo(16)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupButton() {
        self.backgroundColor = .color.gomsAdmin.color
        QRFrame.image = .image.gomsqrIcon.image
        QRIcon.image = .image.gomsAdminQRIcon.image
    }
}
