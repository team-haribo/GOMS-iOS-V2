import UIKit

public class PasswordResetViewController: BaseViewController, UITextFieldDelegate {
    let titleText = UILabel().then {
        $0.text = "비밀번호 재설정"
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
    
    let certificationButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 335, height: 48)
        $0.backgroundColor = .color.gomsPrimary.color
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.setTitle("인증번호 받기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(certificationButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailTextField.delegate = self
    }
    
    // MARK: AddView
    override func addView() {
        [titleText, emailTextField, defaultDomain, certificationButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height)/8.12)
            $0.leading.equalToSuperview().offset(20)
        }

        emailTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalToSuperview().offset((bounds.height)/2.2745098039)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        defaultDomain.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField)
            $0.trailing.equalTo(emailTextField.snp.trailing).inset(16)
        }
        
        certificationButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset((bounds.height)/5.884057971)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
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
    @objc func certificationButtonDidTap() {
        let inputVC = InputNumViewController()
        navigationController?.pushViewController(inputVC, animated: true)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        emailTextField.frame.origin.y = bounds.height/3.1472868217
        defaultDomain.frame.origin.y = bounds.height/2.9103942652
        certificationButton.frame.origin.y = bounds.height/1.8971962617
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        emailTextField.frame.origin.y = bounds.height/2.2745098039
        defaultDomain.frame.origin.y = bounds.height/2.1481481481
        certificationButton.frame.origin.y = bounds.height/1.2971246006
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            emailTextField.textColor = .black
        }
        return true
    }
}
