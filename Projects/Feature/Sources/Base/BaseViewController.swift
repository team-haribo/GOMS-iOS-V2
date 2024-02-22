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
        configureUI()
        configNavigation()
        addView()
        setLayout()
    }
    
    func configureUI(){
        view.backgroundColor = .color.gomsBackground.color
        addView()
        setLayout()
    }
    
    func configNavigation()
    func addView() {}
    func setLayout() {}
}
