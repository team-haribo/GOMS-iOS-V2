import UIKit
import SnapKit
import Then
import Service

final class ProfileCardView: UIView {
    
    var isClockOn: Bool = UserDefaults.standard.bool(forKey: "isClockOn") {
        didSet {
            setLayout()
        }
    }
    
    // MARK: - Properties
    let profileImageView = UIImageView().then {
        $0.image = .image.gomsBasicProfile.image
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 26
        $0.clipsToBounds = true
    }
    
    let nameLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .color.gomsTextDefault.color
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    let studentInformationLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
    }

    let myOutingStatusLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .color.gomsAdmin.color
        $0.font = UIFont.pretendard(size: 16, weight: .bold)
    }
    
    private func configureUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.backgroundColor = .color.gomsCardBackgroundColor.color
    }

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentInformationLabel, myOutingStatusLabel].forEach { self.addSubview($0) }
    }
    
    // MARK: - Layout
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.width.equalTo(52)
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(15)
            $0.height.equalTo(32)
        }
        
        studentInformationLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        myOutingStatusLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
