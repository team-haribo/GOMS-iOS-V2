//
//  LoaderViewController.swift
//  Feature
//
//  Created by 새미 on 6/19/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public class LoaderViewController: BaseViewController {

    private let loadingView = UIImageView(image: .image.loadingView.image)
    
    // MARK: - Life Cycel
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.modalPresentationStyle = .overCurrentContext
            self.modalTransitionStyle = .crossDissolve
        startAnimation()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.isOpaque = false
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
    
    // MARK: - Add View
    override func addView() {
        self.view.addSubview(loadingView)
    }
    
    // MARK: - Layout
    override func setLayout() {
        loadingView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Animation
    private func startAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.0
        rotation.repeatCount = .infinity
        loadingView.layer.add(rotation, forKey: "spin")
    }

    private func stopAnimation() {
        loadingView.layer.removeAllAnimations()
    }
}
