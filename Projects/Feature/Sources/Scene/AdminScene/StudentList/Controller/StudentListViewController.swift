import UIKit

public class StudentListViewController: BaseViewController {
    // MARK: Propertices
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "학생 검색"
    }
    
    private let mainText = UILabel().then {
        $0.text = "검색 결과"
        $0.setDynamicTextColor(darkModeColor: .white, lightModeColor: .black)
        $0.font = .pretendard(size: 18, weight: .semibold)
    }

    private let filterButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 40)
        $0.setTitle("필터", for: .normal)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.addTarget(self, action: #selector(filterButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private let studentListFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = CGSize(width: 335, height: 72)
    }
    
    private lazy var studentListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.studentListFlowLayout).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    // MARK: - CollectionView Setting
    private func setCollectionView() {
        self.studentListCollectionView.dataSource = self
        
        studentListCollectionView.register(StudentListCollectionViewCell.self, forCellWithReuseIdentifier: StudentListCollectionViewCell.identifier)
    }
    
    // MARK: - Configure UI
    override func configureUI() {
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
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
        
        navigationItem.title = "학생 관리"
        navigationItem.searchController = searchController
    }
    
    // MARK: AddView
    override func addView() {
        [mainText, filterButton, studentListCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: SetLayou
    override func setLayout() {
        mainText.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(32)
        }
        
        filterButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        studentListCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainText.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Action
    @objc func filterButtonDidTap(_ sender: Any) {
        print("버튼이 눌렸습니다!")
        
        let bottomSheetVC = BottomSheetViewController(contentViewController: UIViewController(), defaultHeight: 650, cornerRadius: 12, dimmedAlpha: 0.45, isPannedable: true)
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)
    }
}

extension StudentListViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = studentListCollectionView.dequeueReusableCell(withReuseIdentifier: StudentListCollectionViewCell.identifier, for: indexPath) as! StudentListCollectionViewCell
        
        return cell
    }
}
