//
//  UILabel+Extension.swift
//  Feature
//
//  Created by 새미 on 3/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setDynamicTextColor(darkModeColor: UIColor, lightModeColor: UIColor) {
        self.textColor = UIColor { traitCollection -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return darkModeColor
            } else {
                return lightModeColor
            }
        }
    }
}
