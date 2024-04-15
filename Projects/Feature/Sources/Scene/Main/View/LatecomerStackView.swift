import UIKit

import SnapKit
import Then
import Moya
import Service

final class LatecomerStackView: UIStackView {
    
    // MARK: - Properties
    private let provider = MoyaProvider<LateServices>()
    
    private let latecomer1 = LatecomerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name: "김경수", studentInformation: "7기 | IoT")
    
    private let latecomer2 = LatecomerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name: "정민석", studentInformation: "7기 | IoT")
    
    private let latecomer3 = LatecomerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name: "김경수", studentInformation: "7기 | IoT")
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
//        fetchData()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    private func set() {
        self.backgroundColor = .clear
        self.spacing = 0
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        [latecomer1, latecomer2, latecomer3].forEach { self.addArrangedSubview($0) }
    }
    
    // MARK: - Network Request
//    private func fetchData() {
//        provider.request(.lateRank(param: LateRankRequest(lateCount: 3))) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                do {
//                    let lateRankResponse = try response.map(LateRankResponse.self)
//                    self.updateLatecomers(with: lateRankResponse)
//                } catch {
//                    print("Error decoding response: \(error)")
//                }
//            case .failure(let error):
//                print("Network request failed: \(error)")
//            }
//        }
//    }
    
    // MARK: - Update Latecomers
//    private func updateLatecomers(with response: LateRankResponse) {
//        DispatchQueue.main.async {
//            self.latecomer1.update(with: response)
//            self.latecomer2.update(with: response)
//            self.latecomer3.update(with: response)
//        }
//    }
}
