import UIKit

class PasswordSettingViewController: BaseViewController {
    let titleText = UILabel().then {
        $0.text = "비밀번호 재설정"
        $0.font = UIFont.pretendard(size: 29, weight: .bold)
    }
    
    let passwordTextField = UITextField().then {
        let placeholderText = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.color.gomsSecondary.color])
        $0.attributedPlaceholder = placeholderText
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.textAlignment = .left

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        }

    let passwordCheckTextField = UITextField().then {
        let placeholderText = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedString.Key.foregroundColor: UIColor.color.gomsSecondary.color])
        $0.attributedPlaceholder = placeholderText
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.textAlignment = .left

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    
    let infoLabel = UILabel().then {
        $0.text = "대/소문자, 특수문자 포함 12자 이상"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsSecondary.color
    }
    
    let completeButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 335, height: 48)
        $0.backgroundColor = .color.gomsPrimary.color
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: AddView
    override func addView() {
        [titleText, passwordTextField, passwordCheckTextField, infoLabel, completeButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height)/8.12)
            $0.left.equalToSuperview().offset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalToSuperview().offset((bounds.height)/2.5942492013)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        passwordCheckTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalTo(passwordTextField.snp.bottom).offset((bounds.height)/33.8333333333)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset((bounds.height)/101.5)
            $0.left.equalToSuperview().offset(28)
        }
        
        completeButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset((bounds.height)/5.884057971)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
    }
    
    // MARK: Dark Mode SetUp
    private func setupDarkMode() {
        if traitCollection.userInterfaceStyle == .dark {
            // Dark Mode
            titleText.textColor = .white
        } else {
            // Light Mode
            titleText.textColor = .black
        }
    }
    
    // MARK: Action
    @objc func completeButtonDidTap() {
        var alert = UIAlertController(title: "재설정 완료", message:
         "비밀번호가 재설정되었습니다.\n 로그인 화면으로 돌아갑니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Action", style: .default, handler: { action in
            let loginVC = SignInViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        passwordTextField.frame.origin.y = bounds.height/4.4010840108
        passwordCheckTextField.frame.origin.y = bounds.height/2.8948306595
        infoLabel.frame.origin.y = bounds.height/2.3570391872
        completeButton.frame.origin.y = bounds.height/1.9105882353
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        passwordTextField.frame.origin.y = bounds.height/2.849122807
        passwordCheckTextField.frame.origin.y = bounds.height/2.1312335958
        infoLabel.frame.origin.y = bounds.height/1.8247191011
        completeButton.frame.origin.y = bounds.height/1.2971246006
    }
}
