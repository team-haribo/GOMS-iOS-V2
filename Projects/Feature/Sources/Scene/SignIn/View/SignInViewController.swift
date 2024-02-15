import UIKit

class SignInViewController: BaseViewController, UITextFieldDelegate {
    let titleText = UILabel().then {
        $0.text = "로그인"
        $0.font = UIFont.pretendard(size: 29, weight: .bold)
    }
    
    let emailTextField = UITextField().then {
        let placeholderText = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.color.gomsSecondary.color])
        $0.attributedPlaceholder = placeholderText

        let spacing = UIScreen.main.bounds.width / 9

        $0.textColor = .color.gomsSecondary.color
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.textAlignment = .left

        // Add left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }

    let defaultDomain = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .color.gomsSecondary.color
    }
    
    let passwordTextField = UITextField().then {
        let placeholderText = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.color.gomsSecondary.color])
        $0.attributedPlaceholder = placeholderText

        let spacing = UIScreen.main.bounds.width / 9

        $0.textColor = .color.gomsSecondary.color
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.textAlignment = .left

        // Add left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    
    let passwordResetLabel = UILabel().then {
        $0.text = "비밀번호를 잊으셨나요?"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = UIColor.color.gomsSecondary.color
    }
    
    let passwordResetButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 87, height: 48)
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.addTarget(self, action: #selector(passwordResetButtonDidTap), for: .touchUpInside)
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
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: AddView
    override func addView() {
        [titleText, emailTextField, defaultDomain, passwordTextField, passwordResetLabel, passwordResetButton, signInButton].forEach { view.addSubview($0) }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height)/8.12)
            $0.left.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalToSuperview().offset((bounds.height)/2.5942492013)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        defaultDomain.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField)
            $0.right.equalTo(emailTextField.snp.right).inset(16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalTo(emailTextField.snp.bottom).offset((bounds.height)/33.8333333333)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        passwordResetLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset((bounds.height)/67.6666666667)
            $0.left.equalToSuperview().offset((bounds.width)/13.3928571429)
        }
        
        passwordResetButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset((bounds.height)/162.4)
            $0.right.equalToSuperview().inset((bounds.width)/13.3928571429)
        }
        
        signInButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset((bounds.height)/5.884057971)
            $0.left.right.equalToSuperview().inset((bounds.width)/18.75)
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
    @objc func signInButtonDidTap() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @objc func passwordResetButtonDidTap() {
        let passwordResetVC = PasswordResetViewController()
        navigationController?.pushViewController(passwordResetVC, animated: true)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        emailTextField.frame.origin.y = bounds.height/3.7943925234
        defaultDomain.frame.origin.y = bounds.height/3.4553191489
        passwordTextField.frame.origin.y = bounds.height/2.6887417219
        passwordResetLabel.frame.origin.y = bounds.height/2.1653333333
        passwordResetButton.frame.origin.y = bounds.height/2.1945945946
        signInButton.frame.origin.y = bounds.height/1.8971962617
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        emailTextField.frame.origin.y = bounds.height/2.5942492013
        defaultDomain.frame.origin.y = bounds.height/2.4311377246
        passwordTextField.frame.origin.y = bounds.height/2.02493765586
        passwordResetLabel.frame.origin.y = bounds.height/1.7167019027
        passwordResetButton.frame.origin.y = bounds.height/1.735042735
        signInButton.frame.origin.y = bounds.height/1.2971246006
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            emailTextField.textColor = .black
        } else if textField == passwordTextField {
            passwordTextField.textColor = .black
        }
        return true
    }
}
