//
//  MainViewController.swift
//  Feature
//
//  Created by 새미 on 1/10/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class MainViewController: BaseViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    private let logo = UIImageView(image: .image.gomsLogo.image)
    
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
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64)).then {
        $0.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func settingButtonTapped() {
        // Setting ViewController 이동
    }
    
    @objc func moreOutingStatusButtonTapped() {
        // More Outing Status Button Tapped
    }
    
    @objc func qrButtonTapped() {
        // QR Button Tapped
    }

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setDatas()
    }
    
    // MARK: - CollectionView Setting
    private func setCollectionView() {
        self.outingStatusCollectionView.dataSource = self
        self.outingStatusCollectionView.delegate = self
        
        outingStatusCollectionView.register(OutingStatusCollectionViewCell.self, forCellWithReuseIdentifier: OutingStatusCollectionViewCell.identifier)
    }
    
    // MARK: - Data Setting
    private func setDatas() {
        // Data Setting
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        qrButton.layer.cornerRadius = qrButton.frame.size.width / 2
        qrButton.clipsToBounds = true
    }
    
    // MARK: - Add View
    override func addView() {
        [latecomerLabel, latecomerStackView].forEach { latecomerView.addSubview($0) }
        [outingStatusLabel, moreOutingStatusButton, dividingLineView, numberOfPeopleOutingLabel].forEach { outingStatusView.addSubview($0) }
        [logo, settingButton, profileView, latecomerView, outingStatusView, outingStatusCollectionView, qrButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.height.equalTo(56)
            $0.width.equalTo(127)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(22.21877)
            $0.height.equalTo(21.88972)
        }
        
        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(logo.snp.bottom).offset(16)
            $0.height.equalTo(96)
        }

        latecomerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(profileView.snp.bottom).offset(32)
            $0.height.equalTo(216)
        }
        
        latecomerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        latecomerStackView.snp.makeConstraints {
            $0.top.equalTo(latecomerLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        outingStatusView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(latecomerView.snp.bottom).offset(32)
            $0.height.equalTo(100)
        }
        
        outingStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
            $0.top.equalToSuperview().inset(16)
        }
        
        moreOutingStatusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        dividingLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(outingStatusLabel.snp.bottom).offset(4)
        }
        
        numberOfPeopleOutingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(dividingLineView.snp.bottom).offset(6)
            $0.height.equalTo(28)
        }
        
        outingStatusCollectionView.snp.makeConstraints {
            $0.top.equalTo(numberOfPeopleOutingLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
        }
        
        qrButton.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
}

// MARK: - MainViewController Extension
extension MainViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = outingStatusCollectionView.dequeueReusableCell(withReuseIdentifier: OutingStatusCollectionViewCell.identifier, for: indexPath) as! OutingStatusCollectionViewCell
        
        return cell
    }
}
