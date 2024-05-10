import UIKit

public class AdminMainViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel = MainViewModel()
    
    let content = UIView()
    
    private let logo = UIImageView(image: .image.gomsLightGrayLogo.image)
    
    private lazy var adminMenuButton = UIButton().then {
        $0.setBackgroundImage(.image.adminMenu.image, for: .normal)
        $0.addTarget(self, action: #selector(adminMenuButtonTapped), for: .touchUpInside)
    }
    
    private let profileView = MainProfileView()
    
    private let latecomerLabel = UILabel().then {
        $0.text = "지각자 TOP 3"
        $0.setDynamicTextColor(darkModeColor: .white, lightModeColor: .black)
        $0.font = UIFont.pretendard(size: 19, weight: .bold)
    }
    
    let lateNilView = LateNilView()

    lazy var latecomerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .clear
    }
    
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
    
    let outingCountLabel = UILabel().then {
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }

    lazy var outingStatusCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.backgroundColor = .clear
    }
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64), backgroundColor: .color.gomsAdmin.color).then {
        $0.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        latecomerCollectionView.reloadData()
        outingStatusCollectionView.reloadData()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getLateList {
            self.viewModel.getOutingList {
                self.setup()
            }
        }
    }
    
    // MARK: - Setting
    func setup() {
        self.setCollectionView()
        self.setupCountLable()
    }
    
    func nilLatecomers() {
        lateNilView.isHidden = false
    }
    
    func showLatecomers() {
        lateNilView.isHidden = true
    }
    
    private func setCollectionView() {
        self.outingStatusCollectionView.dataSource = self
        self.outingStatusCollectionView.delegate = self
        
        outingStatusCollectionView.register(OutingStatusCollectionViewCell.self, forCellWithReuseIdentifier: OutingStatusCollectionViewCell.identifier)
        
        self.latecomerCollectionView.dataSource = self
        self.latecomerCollectionView.delegate = self
        
        latecomerCollectionView.register(LateCell.self, forCellWithReuseIdentifier: LateCell.identifier)
    }
    
    func setupCountLable() {
        let attributedString = NSMutableAttributedString(string: "\(self.viewModel.outingListDatas.count)명이 외출 중")
        let range = (attributedString.string as NSString).range(of: "\(self.viewModel.outingListDatas.count)")

        attributedString.addAttribute(.foregroundColor, value: UIColor.color.gomsAdmin.color, range: range)
        attributedString.addAttribute(.font, value: UIFont.pretendard(size: 12, weight: .semibold), range: range)

        self.outingCountLabel.attributedText = attributedString
    }
    
    // MARK: - Selector
    @objc func moreOutingStatusButtonTapped() {
        let outingVC = OutingViewController()
        navigationController?.pushViewController(outingVC, animated: true)
    }
    
    @objc func qrButtonTapped() {
        let qrCodeVC = QRCodeViewController()
        self.navigationController?.pushViewController(qrCodeVC, animated: true)
    }
    
    @objc func adminMenuButtonTapped() {
        let adminMenuVC = AdminMenuViewController()
        self.navigationController?.pushViewController(adminMenuVC, animated: true)
        print("admin")
    }

    // MARK: - Configure UI
    override func configureUI() {
        qrButton.layer.cornerRadius = qrButton.frame.size.width / 2
        qrButton.clipsToBounds = true
    }
    
    // MARK: - Add View
    override func addView() {
        [profileView, latecomerLabel, lateNilView, latecomerCollectionView, outingStatusLabel, moreOutingStatusButton, outingCountLabel, outingStatusCollectionView].forEach { self.content.addSubview($0) }
        [logo, adminMenuButton, content, qrButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        logo.snp.makeConstraints {
            $0.top.equalTo(bounds.height * 0.07)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(24)
            $0.width.equalTo(87)
        }
        
        adminMenuButton.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.05)
            $0.top.equalTo(bounds.height * 0.07)
            $0.height.equalTo(18)
            $0.width.equalTo(20)
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom)
            $0.leading.equalTo(bounds.width * 0.05)
            $0.trailing.equalTo(-(bounds.width * 0.05))
            $0.bottom.equalToSuperview()
        }
        
        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(84)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(24)
        }

        latecomerLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        lateNilView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
            $0.top.equalTo(latecomerLabel.snp.bottom).offset(8)
        }
        
        latecomerCollectionView.snp.makeConstraints {
            $0.top.equalTo(latecomerLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(136)
        }
        
        outingStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(32)
            $0.top.equalTo(latecomerCollectionView.snp.bottom).offset(24)
        }
        
        outingCountLabel.snp.makeConstraints {
            $0.top.equalTo(latecomerCollectionView.snp.bottom).offset(24)
            $0.leading.equalTo(outingStatusLabel.snp.trailing).offset(8)
            $0.height.equalTo(32)
        }
        
        moreOutingStatusButton.snp.makeConstraints {
            $0.top.equalTo(latecomerCollectionView.snp.bottom).offset(28)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(48)
            $0.height.equalTo(24)
        }
        
        outingStatusCollectionView.snp.makeConstraints {
            $0.top.equalTo(outingStatusLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        qrButton.snp.makeConstraints {
            $0.trailing.equalTo(-(bounds.width * 0.09))
            $0.bottom.equalTo(-(bounds.height * 0.06))
            $0.height.width.equalTo(64)
        }
    }
}

// MARK: - MainViewController Extension
extension AdminMainViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == outingStatusCollectionView {
            return viewModel.outingListDatas.count
        } else if collectionView == latecomerCollectionView {
            return viewModel.lateListDatas.count
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == outingStatusCollectionView {
            let cell = outingStatusCollectionView.dequeueReusableCell(withReuseIdentifier: OutingStatusCollectionViewCell.identifier, for: indexPath) as! OutingStatusCollectionViewCell
            
            let outingData = viewModel.outingListDatas[indexPath.row]
            cell.setupData(with: outingData)
            
            return cell
        } else if collectionView == latecomerCollectionView {
            let cell = latecomerCollectionView.dequeueReusableCell(withReuseIdentifier: LateCell.identifier, for: indexPath) as! LateCell

            let lateData = viewModel.lateListDatas[indexPath.row]
            cell.setupData(with: lateData)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension AdminMainViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == latecomerCollectionView {
            let width = bounds.width * 0.27
            let height: CGFloat = 136
            return CGSize(width: width, height: height)
        } else if collectionView == outingStatusCollectionView {
            let width = bounds.width * 0.9
            let height: CGFloat = 50
            return CGSize(width: width, height: height)
        }
        return CGSize(width: 0, height: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == latecomerCollectionView {
            return bounds.width * 0.03
        } else if collectionView == outingStatusCollectionView {
            return 0
        }
        return 0
    }
}
