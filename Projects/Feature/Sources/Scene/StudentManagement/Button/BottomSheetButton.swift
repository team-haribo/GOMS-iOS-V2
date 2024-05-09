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
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15).cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
}
