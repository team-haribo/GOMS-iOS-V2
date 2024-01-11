//
//  UIImageView+Extension.swift
//  Feature
//
//  Created by 새미 on 1/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(resource: ImageResource) {
        self.init()
        self.image = UIImage(resource: resource)
    }
}
