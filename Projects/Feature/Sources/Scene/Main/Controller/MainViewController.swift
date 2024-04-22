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
    let scrollView = UIScrollView()
    
    private let logo = UIImageView(image: .image.gomsLightGrayLogo.image)
    
    private let settingButton = UIButton()
    
    private let profileView = ProfileCardView()
    
    private let latecomerView = UIView()
    
    private let latecomerLabel = UILabel().then {
        $0.text = "지각자 TOP 3"
        $0.setDynamicTextColor(darkModeColor: .white, lightModeColor: .black)
        $0.font = UIFont.pretendard(size: 19, weight: .bold)
    }
    
    private let latecomerStackView = LatecomerStackView()
    
    private let latecomerFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = CGSize(width: 303, height: 56)
    }
    
    private lazy var latecomerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.latecomerFlowLayout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .clear
    }
    
    private let outingStatusView = UIView()
    
    private let outingStatusLabel = UILabel().then {
        $0.text = "외출현황"
        $0.setDynamicTextColor(darkModeColor: .white, lightModeColor: .black)
        $0.font = UIFont.pretendard(size: 19, weight: .bold)
    }
    
    private lazy var moreOutingStatusButton = UIButton().then {
        $0.backgroundColor = .color.gomsTextDefault.color.withAlphaComponent(0.1)
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.color.gomsSecondary.color, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 12, weight: .regular)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(moreOutingStatusButtonTapped), for: .touchUpInside)
    }
    
    private let numberOfPeopleOutingLabel = UILabel().then {
        $0.text = "0명이 외출 중"
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 13, weight: .regular)
        let fullText = $0.text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "0")
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.color.gomsPrimary.color.cgColor,
            range: range
        )
        attributedString.addAttribute(
            .font,
            value: UIFont.pretendard(size: 12, weight: .bold),
            range: range
        )
        $0.attributedText = attributedString
    }
    
    private let outingStatusFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = CGSize(width: 303, height: 56)
    }
    
    private lazy var outingStatusCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.outingStatusFlowLayout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.backgroundColor = .clear
    }
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64)).then {
        $0.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func settingButtonTapped() {
        // Setting ViewController 이동
    }
    
    @objc func moreOutingStatusButtonTapped() {
        let outingVC = OutingStatusViewController()
        navigationController?.pushViewController(outingVC, animated: true)
    }
    
    @objc func qrButtonTapped() {
        let qrCodeVC = QRCodeViewController()
        self.navigationController?.pushViewController(qrCodeVC, animated: true)
    }

    // MARK: - Life Cycle
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.updateContentSize()
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        setCollectionView()
        setDatas()
        setIconColor()
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
    
    // MARK: setIconColor
    private func setIconColor() {
        if traitCollection.userInterfaceStyle == .dark {
            logo.image = .image.gomsDarkGrayLogo.image
            settingButton.setBackgroundImage(.image.gomsDarkGraySettingIcon.image, for: .normal)
        } else {
            logo.image = .image.gomsLightGrayLogo.image
            settingButton.setBackgroundImage(.image.gomsLightGraySettingIcon.image, for: .normal)
        }
    }
    
    // MARK: - Add View
    override func addView() {
        [latecomerLabel, latecomerStackView].forEach { latecomerView.addSubview($0) }
        [outingStatusLabel, moreOutingStatusButton, numberOfPeopleOutingLabel, outingStatusCollectionView].forEach { outingStatusView.addSubview($0) }
        [profileView, latecomerView, outingStatusView].forEach { self.scrollView.addSubview($0) }
        [logo, settingButton, scrollView, qrButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview()
            $0.height.equalTo(56)
            $0.width.equalTo(127)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(64)
            $0.height.equalTo(56)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(16)
            $0.height.equalTo(84)
            $0.centerX.equalToSuperview()
        }

        latecomerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(profileView.snp.bottom).offset(32)
            $0.height.equalTo(176)
        }
        
        latecomerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        latecomerStackView.snp.makeConstraints {
            $0.height.equalTo(136)
            $0.top.equalTo(latecomerLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        outingStatusView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(latecomerView.snp.bottom).offset(32)
            $0.height.equalTo(382)
            $0.centerX.equalToSuperview()
        }
        
        outingStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(32)
            $0.top.equalToSuperview()
        }
        
        numberOfPeopleOutingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalTo(outingStatusLabel.snp.trailing).offset(8)
            $0.height.equalTo(20)
        }
        
        moreOutingStatusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(4)
            $0.width.equalTo(48)
            $0.height.equalTo(24)
        }
        
        outingStatusCollectionView.snp.makeConstraints {
            $0.top.equalTo(numberOfPeopleOutingLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(350)
        }
        
        qrButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.width.equalTo(64)
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
