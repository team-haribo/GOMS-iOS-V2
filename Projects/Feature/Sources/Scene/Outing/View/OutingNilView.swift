//
//  OutingNilView.swift
//  Feature
//
//  Created by 새미 on 4/24/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class OutingNilView: UIView {
    
    // MARK: - Properties
    

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
    }

}
