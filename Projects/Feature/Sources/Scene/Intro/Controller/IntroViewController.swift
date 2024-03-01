import UIKit

public class IntroViewController: BaseViewController {
    let iconImage = UIImageView().then {
        $0.image = .image.gomsGoms.image
    }
    
    let explainText = UILabel().then {
        $0.text = "수요 외출제 관리 서비스"
        $0.font = UIFont.pretendard(size: 20, weight: .bold)
    }
    
    let subExplainText = UILabel().then {
        $0.text = "앱으로 간편하게 GSM의 \n수요 외출제를 이용해 보세요!"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    let signInButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 335, height: 48)
        $0.backgroundColor = .color.gomsPrimary.color
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(signInButtonDidTap), for: .touchUpInside)
    }
    
    let firstTimeText = UILabel().then {
        $0.text = "처음이라면?"
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
        $0.textColor = .color.gomsTertiary.color
    }
    
    let firstTimeLine1 = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 134.5, height: 1)
        $0.backgroundColor = .color.gomsTertiary.color
    }

    let firstTimeLine2 = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 134.5, height: 1)
        $0.backgroundColor = .color.gomsTertiary.color
    }
    
    let signUpButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 35, height: 48)
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .color.gomsBackground.color
        setupDarkMode()
        
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // MARK: AddView
    override func addView() {
        [iconImage, explainText, subExplainText, signInButton, firstTimeText, firstTimeLine1, firstTimeLine2, signUpButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        iconImage.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.top.equalTo((bounds.height)/3.1472868217)
            $0.centerX.equalToSuperview()
        }
        
        explainText.snp.makeConstraints {
            $0.top.equalTo(iconImage.snp.bottom).offset((bounds.height)/14.5)
            $0.centerX.equalToSuperview()
        }
        
        subExplainText.snp.makeConstraints {
            $0.top.equalTo(explainText.snp.bottom).offset((bounds.height)/101.5)
            $0.centerX.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset((bounds.height)/5.884057971)
            $0.leading.trailing.equalToSuperview().inset((bounds.width)/18.75)
        }
        
        firstTimeText.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset((bounds.height)/45.1111111111)
            $0.centerX.equalToSuperview()
        }
        
        firstTimeLine1.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(signInButton.snp.bottom).offset((bounds.height)/32.48)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(firstTimeText.snp.leading).offset(-4)
        }
        
        firstTimeLine2.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(signInButton.snp.bottom).offset((bounds.height)/32.48)
            $0.leading.equalTo(firstTimeText.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        signUpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset((bounds.height)/16.24)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Dark Mode SetUp
    private func setupDarkMode() {
        if traitCollection.userInterfaceStyle == .dark {
            // Dark Mode
            explainText.textColor = .white
            let fullText = explainText.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "수요 외출제")
            attribtuedString.addAttribute(
                .foregroundColor,
                value: UIColor.color.gomsPrimary.color,
                range: range
            )
            explainText.attributedText = attribtuedString
        } else {
            // Light Mode
            explainText.textColor = .black
            let fullText = explainText.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "수요 외출제")
            attribtuedString.addAttribute(
                .foregroundColor,
                value: UIColor.color.gomsPrimary.color,
                range: range
            )
            explainText.attributedText = attribtuedString
        }
    }
    
    // MARK: Action
    @objc func signInButtonDidTap() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc func signUpButtonDidTap() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
