import UIKit

public class AdminMainViewController: BaseViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    private let viewModel = MainViewModel()
    
    let scrollView = UIScrollView()
    
    private let logo = UIImageView()
    
    private let studentManagementButton = UIButton()
    
    private let settingButton = UIButton()
    
    private let profileView = MainProfileView()
    
    private let latecomerView = UIView()
    
    private let latecomerLabel = UILabel().then {
        $0.text = "지각자 TOP 3"
        $0.setDynamicTextColor(darkModeColor: .white, lightModeColor: .black)
        $0.font = UIFont.pretendard(size: 19, weight: .bold)
    }
    
    private let latecomerFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = CGSize(width: 104, height: 136)
    }
    
    private lazy var latecomerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.latecomerFlowLayout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .clear
    }
    
    private let outingStatusView = UIView()
    
    private let outingStatusLabel = UILabel().then {
        $0.text = "외출 현황"
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
            value: UIColor.color.gomsAdmin.color.cgColor,
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
    
    private lazy var qrButton = QRButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64), backgroundColor: .color.gomsAdmin.color)

    // MARK: - Life Cycle
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.updateContentSize()
        view.setDynamicBackgroundColor(darkModeColor: .color.gomsBackground.color, lightModeColor: .color.gomsLightBackground.color)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setIconColor()
    }
    
    // MARK: - CollectionView Setting
    private func setCollectionView() {
        self.outingStatusCollectionView.dataSource = self
        self.outingStatusCollectionView.delegate = self
        
        outingStatusCollectionView.register(OutingStatusCollectionViewCell.self, forCellWithReuseIdentifier: OutingStatusCollectionViewCell.identifier)
        
        self.latecomerCollectionView.dataSource = self
        self.latecomerCollectionView.delegate = self
        
        latecomerCollectionView.register(LateCell.self, forCellWithReuseIdentifier: LateCell.identifier)
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
            studentManagementButton.setBackgroundImage(.image.gomsDarkGrayIcon.image, for: .normal)
            settingButton.setBackgroundImage(.image.gomsDarkGraySettingIcon.image, for: .normal)
        } else {
            logo.image = .image.gomsLightGrayLogo.image
            studentManagementButton.setBackgroundImage(.image.gomsLightGrayIcon.image, for: .normal)
            settingButton.setBackgroundImage(.image.gomsSetting.image, for: .normal)
        }
    }
    
    // MARK: - Add View
    override func addView() {
        [latecomerLabel, latecomerCollectionView].forEach { latecomerView.addSubview($0) }
        [outingStatusLabel, moreOutingStatusButton, numberOfPeopleOutingLabel, outingStatusCollectionView].forEach { outingStatusView.addSubview($0) }
        [profileView, latecomerView, outingStatusView].forEach { self.scrollView.addSubview($0) }
        [logo, studentManagementButton, settingButton, scrollView, qrButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Layout
    override func setLayout() {
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 16.9166666667)
            $0.leading.equalToSuperview()
            $0.height.equalTo((bounds.height) / 14.5)
            $0.width.equalTo((bounds.height) / 6.3937007874)
        }
        
        studentManagementButton.snp.makeConstraints {
            $0.trailing.equalTo(settingButton.snp.leading)
            $0.top.equalToSuperview().offset((bounds.height) / 12.8015134794)
            $0.width.equalTo((bounds.height) / 21.9696969697)
            $0.height.equalTo((bounds.height) / 28.6318758815)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 16.24)
            $0.trailing.equalToSuperview()
            $0.width.equalTo((bounds.height) / 12.6875)
            $0.height.equalTo((bounds.height) / 14.5)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 18.75)
            $0.top.equalToSuperview().offset((bounds.height) / 50.75)
            $0.height.equalTo((bounds.height) / 9.6666666667)
            $0.centerX.equalToSuperview()
        }

        latecomerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 18.75)
            $0.top.equalTo(profileView.snp.bottom).offset((bounds.height) / 25.375)
            $0.height.equalTo((bounds.height) / 4.6136363636)
        }
        
        latecomerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo((bounds.height) / 25.375)
        }
        
        latecomerCollectionView.snp.makeConstraints {
            $0.top.equalTo(latecomerLabel.snp.bottom).offset((bounds.height) / 101.5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo((bounds.height) / 5.9705882353)
        }
        
        outingStatusView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 18.75)
            $0.top.equalTo(latecomerView.snp.bottom).offset((bounds.height) / 25.375)
            $0.height.equalTo((bounds.height) / 2.1256544503)
            $0.centerX.equalToSuperview()
        }
        
        outingStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo((bounds.height) / 25.375)
            $0.top.equalToSuperview()
        }
        
        numberOfPeopleOutingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 135.3333333333)
            $0.leading.equalTo(outingStatusLabel.snp.trailing).offset((bounds.width) / 46.875)
            $0.height.equalTo((bounds.height) / 40.6)
        }
        
        moreOutingStatusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset((bounds.height) / 203)
            $0.width.equalTo((bounds.height) / 16.9166666667)
            $0.height.equalTo((bounds.height) / 33.8333333333)
        }
        
        outingStatusCollectionView.snp.makeConstraints {
            $0.top.equalTo(numberOfPeopleOutingLabel.snp.bottom).offset((bounds.height) / 58)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo((bounds.height) / 2.32)
        }
        
        qrButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset((bounds.width) / 18.75)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-((bounds.height) / 50.75))
            $0.height.width.equalTo((bounds.height) / 12.6875)
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
