//
//  LatecomerStackView.swift
//  Feature
//
//  Created by 새미 on 1/29/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class LatecomerStackView: UIStackView {
    
    // MARK: - Properties
    private let latecomer1 = LatecomerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name: "김경수", studentInformation: "7기 | IoT")
    
    private let latecomer2 = LatecomerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name: "정민석", studentInformation: "7기 | IoT")
    
    private let latecomer3 = LatecomerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name: "김경수", studentInformation: "7기 | IoT")
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setting
    private func set() {
        self.backgroundColor = .clear
        self.spacing = 0
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        [latecomer1, latecomer2, latecomer3].forEach { self.addArrangedSubview($0) }
    }
}
