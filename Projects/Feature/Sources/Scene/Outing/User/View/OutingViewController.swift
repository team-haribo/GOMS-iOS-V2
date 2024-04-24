//
//  OutingViewController.swift
//  Feature
//
//  Created by 새미 on 1/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class OutingViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel = OutingViewModel()
    
    var outingList: [OutingListData] = [] {
         didSet {
             outingListCollectionView.reloadData()
             isOutingListNilUI()
         }
     }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let mainLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 18, weight: .semibold)
    }
    
    private let outingListFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = CGSize(width: 335, height: 72)
    }
    
    lazy var outingListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.outingListFlowLayout).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private let outingIsNilIcon = UILabel().then {
        $0.text = "☕️"
        $0.font = .systemFont(ofSize: 80)
        $0.isHidden = true
    }
    
    private let outingIsNilLabel = UILabel().then {
        $0.text = "텅 비었습니다...\n아직 외출할 시간이 아닌가요?"
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = .color.gomsTertiary.color
        $0.setLineSpacing(spacing: 6)
        $0.numberOfLines = 2
        $0.isHidden = true
    }
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64), backgroundColor: .color.gomsPrimary.color).then {
        $0.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func qrButtonTapped() {
        // QR 화면 이동
    }

    // MARK: - Life Cycel
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        outingListCollectionView.reloadData()
    }
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getOutingList {
            self.outingList = self.viewModel.outingListDatas
            self.setup()
            self.isOutingListNilUI()
        }
    }
    
    // MARK: - Setting
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
    
    func setup() {
        setupSearchBar()
        setupCollectionView()
    }
    
    func setupSearchBar() {
        searchController.searchBar.placeholder = "학생 검색"
        searchController.searchResultsUpdater = self
    }
    
    private func setupCollectionView() {
        self.outingListCollectionView.dataSource = self
        
        outingListCollectionView.register(OutingListCollectionViewCell.self, forCellWithReuseIdentifier: OutingListCollectionViewCell.identifier)
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
        qrButton.layer.cornerRadius = qrButton.frame.size.width / 2
        qrButton.clipsToBounds = true
    }
    
    func isOutingListNilUI() {
        if self.viewModel.outingListDatas.count == 0 {
            self.outingIsNilIcon.isHidden = false
            self.outingIsNilLabel.isHidden = false
        } else {
            self.outingIsNilIcon.isHidden = true
            self.outingIsNilLabel.isHidden = true
        }
    }
    
    // MARK: - Add View
    override func addView() {
        [mainLabel, outingListCollectionView, qrButton, outingIsNilIcon, outingIsNilLabel].forEach { view.addSubview($0) }
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
        
        outingIsNilIcon.snp.makeConstraints {
            $0.height.width.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bounds.height * 0.44)
        }
        
        outingIsNilLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(56)
            $0.top.equalTo(outingIsNilIcon.snp.bottom).offset(-16)
        }
        
        qrButton.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
}

extension OutingViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return outingList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = outingListCollectionView.dequeueReusableCell(withReuseIdentifier: OutingListCollectionViewCell.identifier, for: indexPath) as! OutingListCollectionViewCell
    
        let outingData = outingList[indexPath.row]
        cell.configureData(with: outingData)
        
        return cell
    }
}

extension OutingViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        if searchString.isEmpty {
            outingList = viewModel.outingListDatas
        } else {
            viewModel.searchStudent(searchString: searchString) {
                self.outingList = self.viewModel.outingSearchListDatas
                self.outingListCollectionView.reloadData()
            }
        }
    }
}
