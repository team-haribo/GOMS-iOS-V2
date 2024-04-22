import UIKit

class AuthorityBottomSheetContentViewController: BaseViewController {
    private let titleText = UILabel().then {
        $0.text = "유저 권한 변경"
        $0.font = UIFont.pretendard(size: 19, weight: .bold)
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .color.gomsTextDefault.color
        $0.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
    }
    
    var buttonAction: (() -> Void)?
    
    private let outingProhibitionView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let outingProhibitionTitleText = UILabel().then {
        $0.text = "외출금지"
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    private let outingProhibitionInfoText = UILabel().then {
        $0.text = "이 학생은 외출할 수 없어요"
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let outingProhibitionSwitch = UISwitch().then {
        $0.onTintColor = .color.gomsAdmin.color
        $0.isOn = false
        $0.addTarget(self, action: #selector(outingProhibitionOnClickSwitch(_:)), for: UIControl.Event.valueChanged)
    }
    
    private let authorizationView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let authorizationTitleText = UILabel().then {
        $0.text = "학생회 권한 부여"
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    private let authorizationInfoText = UILabel().then {
        $0.text = "이 학생은 학생회에요"
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    private let authorizationSwitch = UISwitch().then {
        $0.onTintColor = .color.gomsAdmin.color
        $0.isOn = false
        $0.addTarget(self, action: #selector(authorizationOnClickSwitch(_:)), for: UIControl.Event.valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addView() {
        [titleText, closeButton, outingProhibitionView, authorizationView].forEach {
            view.addSubview($0)
        }
        
        [outingProhibitionTitleText, outingProhibitionInfoText, outingProhibitionSwitch].forEach {
            outingProhibitionView.addSubview($0)
        }
        
        [authorizationTitleText, authorizationInfoText, authorizationSwitch].forEach {
            authorizationView.addSubview($0)
        }
    }
    
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 50.75)
            $0.leading.equalToSuperview().offset((bounds.width) / 18.75)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 50.75)
            $0.trailing.equalToSuperview().inset((bounds.width) / 18.75)
        }
        
        outingProhibitionView.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(80)
            $0.top.equalTo(titleText.snp.bottom).offset((bounds.height) / 50.75)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 18.75)
        }
        
        outingProhibitionTitleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 50.75)
            $0.leading.equalToSuperview()
        }
        
        outingProhibitionInfoText.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset((bounds.height) / 50.75)
            $0.leading.equalToSuperview()
        }
        
        outingProhibitionSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        authorizationView.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(80)
            $0.top.equalTo(outingProhibitionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 18.75)
        }
        
        authorizationTitleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 50.75)
            $0.leading.equalToSuperview()
        }
        
        authorizationInfoText.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset((bounds.height) / 50.75)
            $0.leading.equalToSuperview()
        }
        
        authorizationSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    // MARK: Action
    @objc private func closeButtonDidTap(_ sender: Any) {
        buttonAction?()
    }
    
    @objc private func outingProhibitionOnClickSwitch(_ sender: Any) {
        // 스위치 관련 액션 추가
        print("스위치")
    }
    
    @objc private func authorizationOnClickSwitch(_ sender: Any) {
        // 스위치 관련 액션 추가
        print("스위치")
    }
}
