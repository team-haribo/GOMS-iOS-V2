//
//  UIView+Extension.swift
//  Feature
//
//  Created by 새미 on 3/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

extension UIView {
    func setDynamicBackgroundColor(darkModeColor: UIColor, lightModeColor: UIColor) {
        self.backgroundColor = UIColor { traitCollection -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return darkModeColor
            } else {
                return lightModeColor
            }
        }
    }
}
