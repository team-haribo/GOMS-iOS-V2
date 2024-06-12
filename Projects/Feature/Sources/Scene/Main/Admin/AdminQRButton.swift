//
//  AdminQRButton.swift
//  Feature
//
//  Created by 새미 on 6/12/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import SnapKit

class AdminQRButton: UIButton {
    
    private let QRIcon = UIImageView()
    
    init(frame: CGRect, backgroundColor: UIColor) {
        super.init(frame: frame)
        setupButton(backgroundColor: backgroundColor)
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
    
    private func setupButton(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        QRIcon.image = .image.adminQRButton.image
    }
}
