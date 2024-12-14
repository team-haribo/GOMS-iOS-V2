//
//  ExpandableButton.swift
//  Feature
//
//  Created by 서지완 on 6/12/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class ExpandableButton: UIButton {
    var expandedTouchArea: CGFloat = 20

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let bounds = self.bounds
        let expandedBounds = bounds.insetBy(dx: -expandedTouchArea, dy: -expandedTouchArea)
        return expandedBounds.contains(point)
    }
}
