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
        self.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.font = .pretendard(size: 16, weight: .regular)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15).cgColor
        self.addPadding()
    }
    
    private func setupPlaceholder() {
        if let placeholderText = placeholderString {
            self.placeholder = placeholderText
        }
    }
}
