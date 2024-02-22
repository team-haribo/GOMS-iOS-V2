//
//  AdminOutingStatusViewController.swift
//  Feature
//
//  Created by 새미 on 2/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class AdminOutingStatusViewController: BaseViewController {
    
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "학생 검색"
    }
    
    private let mainLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.textColor = .white
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
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    // MARK: - CollectionView Setting
    private func setCollectionView() {
        self.outingListCollectionView.dataSource = self
        
        outingListCollectionView.register(AdminOutingStatusCollectionViewCell.self, forCellWithReuseIdentifier: AdminOutingStatusCollectionViewCell.identifier)
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        
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
        [mainLabel, outingListCollectionView].forEach { view.addSubview($0) }
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
    }
}

extension AdminOutingStatusViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = outingListCollectionView.dequeueReusableCell(withReuseIdentifier: AdminOutingStatusCollectionViewCell.identifier, for: indexPath) as! AdminOutingStatusCollectionViewCell
        
        return cell
    }
}
