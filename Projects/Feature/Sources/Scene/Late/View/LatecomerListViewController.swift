//
//  LatecomerListViewController.swift
//  Feature
//
//  Created by 새미 on 4/27/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class LatecomerListViewController: BaseViewController {

    // MARK: - Properties
    var latecomerList: [LatecomerListData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.lateListCollectionView.reloadData()
            }
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 18, weight: .semibold)
    }
    
    private lazy var  filterButton = UIButton().then {
        $0.setTitle("필터", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    lazy var lateListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configNavigation()
    }
    
    @objc func filterButtonTapped() {
        let bottomSheetVC = CalendarBottomSheetVC()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)
    }
    
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지각자 명단"
    }
    
    func setupCollectionView() {
        self.lateListCollectionView.dataSource = self
        self.lateListCollectionView.delegate = self
        lateListCollectionView.register(LatecomerCollectionViewCell.self, forCellWithReuseIdentifier: LatecomerCollectionViewCell.identifier)
    }
    
    override func addView() {
        [titleLabel, filterButton, lateListCollectionView].forEach { view.addSubview($0) }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
        }
        
        filterButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalTo(-bounds.width * 0.05)
        }
        
        lateListCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-(bounds.width * 0.05))
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extension
extension LatecomerListViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latecomerList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = lateListCollectionView.dequeueReusableCell(withReuseIdentifier: LatecomerCollectionViewCell.identifier, for: indexPath) as! LatecomerCollectionViewCell
        
        let latecomerData = latecomerList[indexPath.item]
        cell.configureData(lateData: latecomerData)
        
        return cell
    }
}

extension LatecomerListViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.9
        let height: CGFloat = 72
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
