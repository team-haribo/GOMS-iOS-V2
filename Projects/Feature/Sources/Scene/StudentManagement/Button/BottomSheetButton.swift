//
//  BottomSheetButton.swift
//  Feature
//
//  Created by 새미 on 5/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class BottomSheetButton: UIButton {
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        setButton(withTitle: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton(withTitle title: String) {
        backgroundColor = .clear
        setTitle(title, for: .normal)
        setTitleColor(.color.gomsSecondary.color, for: .normal)
        titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        layer.masksToBounds = true
        layer.borderWidth = 1
        setButtonBorderColor(lightModeColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05), darkModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.15))
        layer.cornerRadius = 12
    }
}
