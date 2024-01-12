//
//  QRButton.swift
//  Feature
//
//  Created by 새미 on 1/12/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit

final class QRButton: UIButton {
    
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
        self.addSubview(QRIcon)
        QRIcon.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupButton() {
        self.backgroundColor = .color.gomsPrimary.color
        QRIcon.image = .image.gomsqrIcon.image
    }
}
