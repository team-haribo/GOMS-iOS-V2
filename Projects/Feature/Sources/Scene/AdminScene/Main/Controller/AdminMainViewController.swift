//
//  AdminMainViewController.swift
//  Feature
//
//  Created by 새미 on 2/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public class AdminMainViewController: BaseViewController {
    
    // MARK: - Properties
    let scrollView = UIScrollView()
    
    private let logo = UIImageView(image: .image.gomsLogo.image)
    
    private let studentManagementButton = UIButton()
    
    private let settingButton = UIButton().then {
        $0.setBackgroundImage(.image.gomsSettingIcon.image, for: .normal)
    }
    
    private let profileView = ProfileCardView()
    
    private let latecomerView = UIView().then {
        $0.backgroundColor = .color.gomsBackground.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsTertiary.color.cgColor
    }
    
    private let latecomerLabel = UILabel().then {
        $0.text = "지각자 TOP 3"
        $0.textColor = .white
        $0.font = UIFont.pretendard(size: 24, weight: .bold)
    }
    
    private let latecomerStackView = LatecomerStackView()
    
    private let outingStatusView = UIView().then {
        $0.backgroundColor = .color.gomsBackground.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsTertiary.color.cgColor
    }
    
    private let outingStatusLabel = UILabel().then {
        $0.text = "외출 현황"
        $0.textColor = .white
        $0.font = UIFont.pretendard(size: 24, weight: .bold)
    }
    
    private lazy var moreOutingStatusButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.color.gomsTertiary.color, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 16, weight: .regular)
        $0.addTarget(self, action: #selector(moreOutingStatusButtonTapped), for: .touchUpInside)
    }
    
    private let dividingLineView = UIView().then {
        $0.backgroundColor = .color.gomsTertiary.color
    }
    
    let numberOfPeopleOutingLabel = UILabel().then {
        $0.text = "66명이 외출 중"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let outingStatusFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = CGSize(width: 303, height: 56)
    }
    
    private lazy var outingStatusCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.outingStatusFlowLayout).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64)).then {
        $0.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
