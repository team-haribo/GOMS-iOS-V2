//
//  OutingStatusViewController.swift
//  Feature
//
//  Created by 새미 on 1/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class OutingStatusViewController: BaseViewController {
    
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "학생 검색"
    }
    
    private let mainLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.setDynamicTextColor(darkModeColor: .white, lightModeColor: .black)
        $0.font = .pretendard(size: 18, weight: .semibold)
    }
    
    private let outingListFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = CGSize(width: 335, height: 72)
    }
    
    private lazy var outingListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.outingListFlowLayout).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64)).then {
        $0.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func qrButtonTapped() {
        // QR 화면 이동
    }

    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    // MARK: - CollectionView Setting
    private func setCollectionView() {
        self.outingListCollectionView.dataSource = self
        
        outingListCollectionView.register(OutingListCollectionViewCell.self, forCellWithReuseIdentifier: OutingListCollectionViewCell.identifier)
    }

    // MARK: - Configure UI
    override func configureUI() {
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
        qrButton.layer.cornerRadius = qrButton.frame.size.width / 2
        qrButton.clipsToBounds = true
    }
    
    // MARK: - Configure Navigation
    override func configNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "외출 현황"
        navigationItem.searchController = searchController
    }
    
    // MARK: - Add View
    override func addView() {
        [mainLabel, outingListCollectionView, qrButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(32)
        }
        
        outingListCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        qrButton.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
}

extension OutingStatusViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = outingListCollectionView.dequeueReusableCell(withReuseIdentifier: OutingListCollectionViewCell.identifier, for: indexPath) as! OutingListCollectionViewCell
        
        return cell
    }
}
