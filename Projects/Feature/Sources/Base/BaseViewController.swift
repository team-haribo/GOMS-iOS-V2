//
//  BaseViewController.swift
//  Feature
//
//  Created by 새미 on 1/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class BaseViewController: UIViewController {
    
    let bounds = UIScreen.main.bounds

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
        configNavigation()
        configureUI()
        addView()
        setLayout()
    }
    
    func configNavigation() {
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func configureUI() {}
    func addView() {}
    func setLayout() {}
}
