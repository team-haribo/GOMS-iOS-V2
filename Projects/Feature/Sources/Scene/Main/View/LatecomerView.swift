import UIKit

import SnapKit
import Then
import Moya
import Service

final class LatecomerView: UIView {
    
    // MARK: - Properties
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56)).then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = .color.gomsSecondary.color
    }
    
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
        configureUI(name, studentInformation)
        addView()
        setLayout()
        setProfile()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI(_ name: String, _ studentInformation: String) {
        self.backgroundColor = .clear
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        nameLabel.text = name
        studentInformationLabel.text = studentInformation
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
    
    private func setProfile() {
        let provider = MoyaProvider<LateServices>()
        provider.request(.lateRank(param: LateRankRequest(lateCount: 3))) { result in
            switch result {
            case .success(let response):
                do {
                    let lateRankResponse = try? response.map(LateRankResponse.self)
                    
                    if let lateRankResponse = lateRankResponse {
                        DispatchQueue.main.async {
                            if let profileUrlString = lateRankResponse.profileUrl, let profileUrl = URL(string: profileUrlString) {
                                let profileProvider = MoyaProvider<AccountServices>()
                                profileProvider.request(.accountProfile) { result in
                                    switch result {
                                    case .success(let response):
                                        if let image = UIImage(data: response.data) {
                                            DispatchQueue.main.async {
                                                self.profileImageView.image = image
                                            }
                                        }
                                    case .failure(let error):
                                        print("Failed to fetch image: \(error)")
                                        DispatchQueue.main.async {
                                            self.profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
                                }
                            }
                            self.nameLabel.text = lateRankResponse.name
                            self.studentInformationLabel.text = "\(lateRankResponse.major)기 | \(lateRankResponse.grade)"
                        }
                    }
                } catch {
                    print("응답 디코딩 오류: \(error)")
                }
            case .failure(let error):
                print("네트워크 요청 실패: \(error)")
            }
        }
    }
}
