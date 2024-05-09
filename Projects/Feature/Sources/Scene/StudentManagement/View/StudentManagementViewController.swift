//
//  StudentManagementViewController.swift
//  Feature
//
//  Created by 새미 on 5/2/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

public final class StudentManagementViewController: BaseViewController {

    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let titleLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 18, weight: .semibold)
    }
    
    private let filterButton = UIButton().then {
        $0.setTitle("필터", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
    }
    
    lazy var studentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
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
        configNavigation()
        setupCollectionView()
        setupSearchBar()
    }
    
    override func configNavigation() {
        super.configNavigation()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "학생 관리"
        navigationItem.searchController = searchController
    }
    
    private func setupCollectionView() {
        self.studentCollectionView.dataSource = self
        self.studentCollectionView.delegate = self
        studentCollectionView.register(StudentCollectionViewCell.self, forCellWithReuseIdentifier: StudentCollectionViewCell.identifier)
    }
    
    func setupSearchBar() {
        searchController.searchBar.placeholder = "학생 검색"
        searchController.searchResultsUpdater = self
    }
    
    override func addView() {
        [titleLabel, filterButton, studentCollectionView].forEach { view.addSubview($0) }
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
        
        studentCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-(bounds.width * 0.05))
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extension
extension StudentManagementViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = studentCollectionView.dequeueReusableCell(withReuseIdentifier: StudentCollectionViewCell.identifier, for: indexPath) as! StudentCollectionViewCell
        
        return cell
    }
}

extension StudentManagementViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.9
        let height: CGFloat = 72
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension StudentManagementViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
      
    }
}
