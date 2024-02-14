import UIKit

public class SettingViewController: BaseViewController {
    let profileView = UIView().then {
        $0.backgroundColor = .color.gomsBackground.color
    }
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    let editButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24)).then {
        $0.setBackgroundImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        $0.backgroundColor = .white
        $0.tintColor = .color.gomsPrimary.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.bounds.width / 2
    }
    
    let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    let classLabel = UILabel().then {
        $0.text = "7기 | IoT"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsSecondary.color
    }
    
    let tardyLabel = UILabel().then {
        $0.text = "지각 횟수"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsSecondary.color
    }
    
    let tardyCountLabel = UILabel().then {
        $0.text = "11 번"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    // MARK: ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        setupDarkMode()
    }
    
    // MARK: AddView
    override func addView() {
        [profileView].forEach { view.addSubview($0) }
        [profileImage, editButton, nameLabel, classLabel, tardyLabel, tardyCountLabel].forEach { profileView.addSubview($0) }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        profileView.snp.makeConstraints {
            $0.height.equalTo(96)
            $0.top.equalToSuperview().offset(120)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        profileImage.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(0)
        }
        
        editButton.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.bottom.equalToSuperview().inset(16)
            $0.left.equalToSuperview().offset(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.left.equalTo(profileImage.snp.right).offset(16)
        }
        
        classLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(21)
            $0.left.equalTo(profileImage.snp.right).offset(16)
        }
        
        tardyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.right.equalToSuperview().inset(0)
        }
        
        tardyCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(21)
            $0.right.equalToSuperview().inset(0)
        }
    }
    
    // MARK: Dark Mode SetUp
    private func setupDarkMode() {
        if traitCollection.userInterfaceStyle == .dark {
            // Dark Mode
            nameLabel.textColor = .white
            tardyCountLabel.textColor = .white
            let fullText = tardyCountLabel.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "11")
            attribtuedString.addAttribute(
                .foregroundColor,
                value: UIColor.color.gomsNegative.color,
                range: range
            )
            tardyCountLabel.attributedText = attribtuedString
            
        } else {
            // Light Mode
            nameLabel.textColor = .black
            tardyCountLabel.textColor = .black
            let fullText = tardyCountLabel.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "11")
            attribtuedString.addAttribute(
                .foregroundColor,
                value: UIColor.color.gomsNegative.color,
                range: range
            )
            tardyCountLabel.attributedText = attribtuedString
        }
    }
}
