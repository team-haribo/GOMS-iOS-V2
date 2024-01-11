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

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureuI()
    }
    
    func configureuI(){
        view.backgroundColor = .color.gomsBackground.color
        addView()
        setLayout()
    }
    
    func addView() {}
    func setLayout() {}
}
