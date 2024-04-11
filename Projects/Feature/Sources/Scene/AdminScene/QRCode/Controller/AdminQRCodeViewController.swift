import UIKit

class AdminQRCodeViewController: BaseViewController {
    // MARK: Propertices
    private let titleText = UILabel().then {
        $0.text = "외출 QR코드"
        $0.textColor = .color.gomsTheme.color
        $0.font = UIFont.pretendard(size: 29, weight: .bold)
    }
    
    private let lastTimeText = UILabel().then {
        $0.text = "QR코드 만료까지"
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
    }
    
    private let lastTimer = UILabel().then {
        $0.text = "5분 00초"
        $0.textColor = .color.gomsAdmin.color
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Add View
    override func addView() {
        [titleText, lastTimeText, lastTimer].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: Set Layout
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(20)
        }
    }
}
