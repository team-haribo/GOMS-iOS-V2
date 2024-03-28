//
//  GOMSTextFieldButton.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public class GOMSTextFieldButton: UIButton {

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        setButton(withTitle: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton(withTitle title: String) {
        backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        setTitle(title, for: .normal)
        setTitleColor(.color.gomsTertiary.color, for: .normal)
        titleLabel?.font = .pretendard(size: 16, weight: .regular)
        layer.masksToBounds = true
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15).cgColor
        contentHorizontalAlignment = .leading
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
