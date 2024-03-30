//
//  UITextField+Extension.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public extension UITextField {
    
    func addPadding(paddingFrame: CGRect) {
        let paddingView = UIView(frame: paddingFrame)
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    
    func setTextFieldBackgroundColor(lightModeColor: UIColor, darkModeColor: UIColor) {
        let backgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkModeColor : lightModeColor
        }
        self.backgroundColor = backgroundColor
    }
    
    func setBorderColorMode(lightModeColor: UIColor, darkModeColor: UIColor) {
        let borderColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkModeColor : lightModeColor
        }
        self.layer.borderColor = borderColor.cgColor
    }
}
