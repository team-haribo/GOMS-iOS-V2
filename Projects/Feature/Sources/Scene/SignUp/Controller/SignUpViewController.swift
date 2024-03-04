import UIKit

public class SignUpViewController: BaseViewController, UITextFieldDelegate {
    let titleText = UILabel().then {
        $0.text = "회원가입"
        $0.font = UIFont.pretendard(size: 29, weight: .bold)
    }
    
    let nameTextField = UITextField().then {
        let placeholderText = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor: UIColor.color.gomsSecondary.color])
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
    
    let genderSelectButton = UIButton().then {
        $0.setTitle("성별", for: .normal)
        $0.setTitleColor(.color.gomsSecondary.color, for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.contentHorizontalAlignment = .left
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        $0.addTarget(self, action: #selector(genderSelectButtonDidTap), for: .touchUpInside)
    }
    
    let classSelectButton = UIButton().then {
        $0.setTitle("과", for: .normal)
        $0.setTitleColor(.color.gomsSecondary.color, for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.contentHorizontalAlignment = .left
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        $0.addTarget(self, action: #selector(classSelectButtonDidTap), for: .touchUpInside)
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
        
        nameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    // MARK: AddView
    override func addView() {
        [titleText, nameTextField, emailTextField, defaultDomain, genderSelectButton, classSelectButton, certificationButton].forEach { view.addSubview($0) }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height)/8.12)
            $0.leading.equalToSuperview().offset(20)
        }
        
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalToSuperview().offset((bounds.height)/3.592920354)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalTo(nameTextField.snp.bottom).offset((bounds.height)/25.375)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        defaultDomain.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField)
            $0.trailing.equalTo(emailTextField.snp.trailing).inset(16)
        }
        
        genderSelectButton.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalTo(emailTextField.snp.bottom).offset((bounds.height)/25.375)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        classSelectButton.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.top.equalTo(genderSelectButton.snp.bottom).offset((bounds.height)/25.375)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
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
    
    @objc func genderSelectButtonDidTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let maleAction = UIAlertAction(title: "남성", style: .default) { _ in
            self.genderSelectButton.setTitle("남성", for: .normal)
            self.genderSelectButton.setTitleColor(.black, for: .normal)
            self.genderSelectButton.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        }
            
        let femaleAction = UIAlertAction(title: "여성", style: .default) { _ in
            self.genderSelectButton.setTitle("여성", for: .normal)
            self.genderSelectButton.setTitleColor(.black, for: .normal)
            self.genderSelectButton.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        }
            
        alert.addAction(maleAction)
        alert.addAction(femaleAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func classSelectButtonDidTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let swAction = UIAlertAction(title: "SW개발과", style: .default) { _ in
            self.classSelectButton.setTitle("SW개발과", for: .normal)
            self.classSelectButton.setTitleColor(.black, for: .normal)
            self.classSelectButton.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        }
            
        let iotAction = UIAlertAction(title: "스마트IoT과", style: .default) { _ in
            self.classSelectButton.setTitle("스마트IoT과", for: .normal)
            self.classSelectButton.setTitleColor(.black, for: .normal)
            self.classSelectButton.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        }
        
        let aiAction = UIAlertAction(title: "AI개발과", style: .default) { _ in
            self.classSelectButton.setTitle("AI개발과", for: .normal)
            self.classSelectButton.setTitleColor(.black, for: .normal)
            self.classSelectButton.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        }
            
        alert.addAction(swAction)
        alert.addAction(iotAction)
        alert.addAction(aiAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            nameTextField.textColor = .black
        } else if textField == emailTextField {
            emailTextField.textColor = .black
        }
        return true
    }
}
