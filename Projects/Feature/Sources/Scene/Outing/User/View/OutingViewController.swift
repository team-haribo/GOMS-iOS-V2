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
         }
     }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let searchTitle = UILabel().then {
        $0.text = "검색 결과"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 18, weight: .semibold)
    }
    
    lazy var outingListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private let outingNillView = OutingNilView().then {
        $0.isHidden = true
    }
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64), backgroundColor: .color.gomsPrimary.color).then {
        $0.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func qrButtonTapped() {
        let qrCodeVC = QRCodeViewController()
        self.navigationController?.pushViewController(qrCodeVC, animated: true)
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
        }
    }
    
    // MARK: - Setting
    override func configNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "외출 현황"
        navigationItem.searchController = searchController
    }
    
    func setup() {
        if outingList.isEmpty {
            searchTitle.isHidden = true
            outingNillView.isHidden = false
        } else {
            searchTitle.isHidden = false
            outingNillView.isHidden = true
        }
        setupSearchBar()
        setupCollectionView()
    }
    
    func setupSearchBar() {
        searchController.searchBar.placeholder = "학생 검색"
        searchController.searchResultsUpdater = self
    }
    
    private func setupCollectionView() {
        self.outingListCollectionView.dataSource = self
        self.outingListCollectionView.delegate = self
        outingListCollectionView.register(OutingListCollectionViewCell.self, forCellWithReuseIdentifier: OutingListCollectionViewCell.identifier)
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
        qrButton.layer.cornerRadius = qrButton.frame.size.width / 2
        qrButton.clipsToBounds = true
    }
    
    // MARK: - Add View
    override func addView() {
        [searchTitle, outingListCollectionView, outingNillView, qrButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        searchTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
        }
        
        outingListCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchTitle.snp.bottom).offset(8)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-(bounds.width * 0.05))
            $0.bottom.equalToSuperview()
        }
        
        outingNillView.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-(bounds.width * 0.05))
            $0.height.equalTo(40)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        qrButton.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.trailing.equalTo(-(bounds.width * 0.05))
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
}

// MARK: - Extension
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

extension OutingViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bounds.width * 0.9
        let height: CGFloat = 72
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
