//
//  AuthorityBottomSheetViewController.swift
//  Feature
//
//  Created by 새미 on 5/9/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class AuthorityBottomSheetViewController: UIViewController {

    // MARK: - Properties
    private let bottomSheetView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "필터"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 19, weight: .bold)
    }
    
    private lazy var closeButton = UIButton().then {
        $0.setBackgroundImage(.image.cancelButton.image, for: .normal)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycel
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    


}
