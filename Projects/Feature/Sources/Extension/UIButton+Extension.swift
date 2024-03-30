//
//  UIButton+Extension.swift
//  Feature
//
//  Created by 새미 on 3/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setTitleColorForMode(darkModeColor: UIColor, lightModeColor: UIColor) {
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        let titleColor = darkModeColor.resolvedColor(with: traitCollection)
        setTitleColor(titleColor, for: .normal)
    }
    
    func setButtonBackgroundColor(lightModeColor: UIColor, darkModeColor: UIColor) {
        let backgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkModeColor : lightModeColor
        }
        self.backgroundColor = backgroundColor
    }
    
    func setButtonBorderColor(lightModeColor: UIColor, darkModeColor: UIColor) {
        let borderColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkModeColor : lightModeColor
        }
        self.layer.borderColor = borderColor.cgColor
    }
}
