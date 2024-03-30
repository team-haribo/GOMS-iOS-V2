//
//  GOMSTextField.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public class GOMSTextField: UITextField {
    
    var placeholderString: String?
    
    let lightBackground = UIColor(red: 0.967, green: 0.97, blue: 0.973, alpha: 1).cgColor
    let darkBackground = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupTextField()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    convenience init(frame: CGRect, placeholder: String?) {
        self.init(frame: frame)
        self.placeholderString = placeholder
        setupPlaceholder()
    }
    
    private func setupTextField() {
        self.setTextFieldBackgroundColor(lightModeColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05), darkModeColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1))
        self.font = .pretendard(size: 16, weight: .regular)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.setBorderColorMode(lightModeColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05), darkModeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.15))
        self.addPadding(paddingFrame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
    }
    
    private func setupPlaceholder() {
        if let placeholderText = placeholderString {
            self.placeholder = placeholderText
            self.setPlaceholderColor(.color.gomsTertiary.color)
        }
    }
}
