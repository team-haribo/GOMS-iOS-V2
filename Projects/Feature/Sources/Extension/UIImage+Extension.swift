//
//  UIImage+Extension.swift
//  Feature
//
//  Created by 새미 on 1/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

extension UIImage {
    enum Images {
        static let goms = UIImage(resource: .GOMS_GOMS)
        static let logo = UIImage(resource: .gomsLogo)
        static let QRIcon = UIImage(resource: .gomsQRIcon)
        static let settingIcon = UIImage(resource: .gomsSettingIcon)
        static let whiteLogo = UIImage(resource: .gomsWhiteLogo)
    }
    
    static let image = FeatureAsset.Images.self
}
