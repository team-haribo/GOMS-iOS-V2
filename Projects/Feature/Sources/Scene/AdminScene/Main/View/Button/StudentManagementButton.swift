//
//  StudentManagementButton.swift
//  Feature
//
//  Created by 새미 on 2/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

final class StudentManagementButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.pretendard(size: 16, weight: .semibold)
        
        config.attributedTitle = AttributedString("학생 관리", attributes: titleContainer) 
        config.baseForegroundColor = .color.gomsSecondary.color
        config.image = .image.gomsAdminIcon.image
        config.imagePadding = 3.18
        config.baseBackgroundColor = .clear
        
        self.configuration = config
    }
}
