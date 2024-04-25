//
//  AdminOutingViewController.swift
//  Feature
//
//  Created by 새미 on 2/22/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class AdminOutingViewController: BaseViewController, AdminOutingCellDelegate {
    
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
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private let outingNillView = OutingNilView().then {
        $0.isHidden = true
    }
    
    // MARK: - Life Cycel
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getOutingList {
            self.outingList = self.viewModel.outingListDatas
            self.setup()
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
        setupCollectionView()
        setupSearchBar()
    }

    private func setupCollectionView() {
        self.outingListCollectionView.dataSource = self
        self.outingListCollectionView.delegate  = self
        
        outingListCollectionView.register(AdminOutingCollectionViewCell.self, forCellWithReuseIdentifier: AdminOutingCollectionViewCell.identifier)
    }
    
    func setupSearchBar() {
        searchController.searchBar.placeholder = "학생 검색"
        searchController.searchResultsUpdater = self
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
    }
    
    // MARK: - Add View
    override func addView() {
        [searchTitle, outingListCollectionView, outingNillView].forEach { view.addSubview($0) }
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
    }
}

// MARK: - Extension
extension AdminOutingViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return outingList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = outingListCollectionView.dequeueReusableCell(withReuseIdentifier: AdminOutingCollectionViewCell.identifier, for: indexPath) as! AdminOutingCollectionViewCell
        
        cell.delegate = self
        cell.tag = indexPath.row
        
        let outingData = outingList[indexPath.row]
        cell.configureData(with: outingData)
        
        return cell
    }
}

extension AdminOutingViewController: UICollectionViewDelegate {
    func deleteButtonTapped(index: Int) {
        let alertController = UIAlertController(title: "외출 강제 복귀", message: "외출자를 강제로 복귀시키시겠습니까?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "복귀", style: .destructive, handler: { _ in
            self.viewModel.deleteOutingStudent(index: index) {
                self.outingList = self.viewModel.outingListDatas
                DispatchQueue.main.async {
                    self.outingListCollectionView.reloadData()
                }
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
}

extension AdminOutingViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.9
        let height: CGFloat = 72
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension AdminOutingViewController: UISearchResultsUpdating {
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
