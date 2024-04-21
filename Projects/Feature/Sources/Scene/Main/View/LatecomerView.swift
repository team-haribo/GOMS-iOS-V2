import UIKit

import SnapKit
import Then
import Moya
import Kingfisher
import Service

final class LatecomerView: UIView {
    
    // MARK: - Properties
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
    
    let nameLabel = UILabel().then {
        $0.font = .pretendard(size: 16, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .color.gomsSecondary.color
    }
    
    let studentInformationLabel = UILabel().then {
        $0.font = .pretendard(size: 12, weight: .regular)
        $0.textAlignment = .center
        $0.textColor = .color.gomsTertiary.color
    }

    // MARK: - Initializer
    init(frame: CGRect, name: String, studentInformation: String) {
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
        self.backgroundColor = .clear
    }
    
    func configureData(with lateRankData: LateRankData) {
        if let imageURL = lateRankData.profileImageURL, let url = URL(string: imageURL) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"))
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        }
        nameLabel.text = lateRankData.name
        studentInformationLabel.text = "\(lateRankData.grade)기 | \(lateRankData.major)"
    }
    
    // MARK: - Add View
    private func addView() {
        [profileImageView, nameLabel, studentInformationLabel].forEach {
            self.addSubview($0)
        }
    }
    
    // MARK: - Layout
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(56)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.height.equalTo(28)
            $0.centerX.equalToSuperview()
        }
        
        studentInformationLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
