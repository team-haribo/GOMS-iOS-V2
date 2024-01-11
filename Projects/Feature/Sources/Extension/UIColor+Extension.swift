//
//  UIColor+Extension.swift
//  Feature
//
//  Created by 새미 on 1/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

extension UIColor {
    enum Colors {
        static let information = UIColor(resource: .gomsInformation)
        static let negative  = UIColor(resource: .gomsNegative)
        static let primary = UIColor(resource: .gomsPrimary)
        static let secondary = UIColor(resource: .gomsSecondary)
        static let tertiary = UIColor(resource: .gomsTertiary)
        static let background = UIColor(resource: .gomsBackground)
    }
    
    static let color = FeatureAsset.Colors.self
}
