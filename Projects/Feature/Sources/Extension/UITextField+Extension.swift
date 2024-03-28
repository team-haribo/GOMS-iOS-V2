//
//  UITextField+Extension.swift
//  Feature
//
//  Created by 새미 on 3/28/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addPadding(paddingFrame: CGRect) {
        let paddingView = UIView(frame: paddingFrame)
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
