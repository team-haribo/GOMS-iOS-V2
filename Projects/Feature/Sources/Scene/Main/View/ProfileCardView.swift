import UIKit
import SnapKit
import Then

final class ProfileCardView: UIView {
    
    // MARK: - Properties
    let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    let studentInformationLabel = UILabel().then {
        $0.text = "7기 | IoT"
        $0.textColor = .color.gomsTertiary.color
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
    }

    private let studentCouncilLabel = UILabel().then {
        $0.text = "외출 대기 중"
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 16, weight: .bold)
    }
    
    private let currentTime = CurrentTimeView(frame: CGRect(x: 0, y: 0, width: 140, height: 40))
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        self.setDynamicBackgroundColor(darkModeColor: .color.gomsDarkGray.color, lightModeColor: .white)
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.backgroundColor = .color.gomsCardBackgroundColor.color
    }
    
    // MARK: - Add View
    private func addView() {
        [nameLabel, studentInformationLabel, studentCouncilLabel, currentTime].forEach { self.addSubview($0) }
    }
    
    // MARK: - Layout
    private func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }
        
        studentInformationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        studentCouncilLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        
        currentTime.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
