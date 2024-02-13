import UIKit

class InputNumViewController: BaseViewController, UITextFieldDelegate {
    let titleText = UILabel().then {
        $0.text = "인증번호 입력"
        $0.font = UIFont.pretendard(size: 29, weight: .bold)
    }
    
    let firstCNum = UITextField().then {
        $0.frame = CGRect(x: 0, y: 0, width: 72, height: 64)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.keyboardType = .numberPad
    }
    
    let secondCNum = UITextField().then {
        $0.frame = CGRect(x: 0, y: 0, width: 72, height: 64)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.keyboardType = .numberPad
    }
    
    let thirdCNum = UITextField().then {
        $0.frame = CGRect(x: 0, y: 0, width: 72, height: 64)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.keyboardType = .numberPad
    }
    
    let fourthCNum = UITextField().then {
        $0.frame = CGRect(x: 0, y: 0, width: 72, height: 64)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color.gomsSecondary.color.cgColor
        $0.keyboardType = .numberPad
    }
    
    let timerLabel = UILabel().then {
        $0.text = "5:00"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = UIColor.color.gomsSecondary.color
    }
    
    let reSendButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 42, height: 48)
        $0.setTitle("재발송", for: .normal)
        $0.setTitleColor(.color.gomsInformation.color, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(reSendButtonDidTap), for: .touchUpInside)
    }
    
    let certifiCompleteButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 335, height: 48)
        $0.backgroundColor = .color.gomsPrimary.color
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.setTitle("인증", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(certiCompleteButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        firstCNum.delegate = self
        secondCNum.delegate = self
        thirdCNum.delegate = self
        fourthCNum.delegate = self
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setTime()
    }
    
    // MARK: AddView
    override func addView() {
        [titleText, firstCNum, secondCNum, thirdCNum, fourthCNum, timerLabel, reSendButton, certifiCompleteButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height)/8.12)
            $0.left.equalToSuperview().offset(20)
        }
        
        let spacing = (UIScreen.main.bounds.width - 72 * 4 - 20 * 2) / 3
        
        firstCNum.snp.makeConstraints {
            $0.width.equalTo(72)
            $0.height.equalTo(64)
            $0.top.equalToSuperview().offset((bounds.height)/2.01990049751)
            $0.left.equalToSuperview().offset((bounds.width)/18.75)
        }
        
        secondCNum.snp.makeConstraints {
            $0.width.height.equalTo(firstCNum)
            $0.top.equalTo(firstCNum)
            $0.left.equalTo(firstCNum.snp.right).offset(spacing)
        }

        thirdCNum.snp.makeConstraints {
            $0.width.height.equalTo(firstCNum)
            $0.top.equalTo(firstCNum)
            $0.left.equalTo(secondCNum.snp.right).offset(spacing)
        }

        fourthCNum.snp.makeConstraints {
            $0.width.height.equalTo(firstCNum)
            $0.top.equalTo(firstCNum)
            $0.right.equalToSuperview().inset((bounds.width)/18.75)
        }
        
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(firstCNum.snp.bottom).offset((bounds.height)/67.6666666667)
            $0.left.equalToSuperview().offset((bounds.width)/13.3928571429)
        }
        
        reSendButton.snp.makeConstraints {
            $0.top.equalTo(fourthCNum.snp.bottom).offset((bounds.height)/162.4)
            $0.right.equalToSuperview().inset((bounds.width)/13.3928571429)
        }
        
        certifiCompleteButton.snp.makeConstraints {
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
    
    // MARK: TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 입력된 문자열이 삭제(Backspace)인 경우에는 처리하지 않음
        guard string != "" else {
            return true
        }
            
        // 현재 텍스트 필드의 텍스트 길이가 1 이상인 경우에는 입력을 받지 않음
        guard textField.text?.count ?? 0 < 1 else {
            return false
        }
            
        // 입력된 문자열이 숫자인 경우에만 처리
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        guard string.rangeOfCharacter(from: allowedCharacterSet) != nil else {
            return false
        }
            
        // 다음 텍스트 필드로 포커스 이동
        switch textField {
        case firstCNum:
            secondCNum.becomeFirstResponder()
        case secondCNum:
            thirdCNum.becomeFirstResponder()
        case thirdCNum:
            fourthCNum.becomeFirstResponder()
        case fourthCNum:
            textField.resignFirstResponder()
        default:
            break
        }
        
        textField.text = string
        textField.textAlignment = .center
        textField.font = UIFont.pretendard(size: 24, weight: .semibold)
        
        return false
    }
    
    // MARK: TimerAction
    var limitTime: Int = 300 // 5분
    
    @objc func setTime() {
        setToTime(sec: limitTime)
        limitTime -= 1
    }
    
    func setToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            timerLabel.text = String(minute) + ":" + "0" + String(second)
        } else {
            timerLabel.text = String(minute) + ":" + String(second)
        }
        
        if limitTime != 0 {
            perform(#selector(setTime), with: nil, afterDelay: 1.0)
        } else if limitTime == 0 {
            timerLabel.isHidden = true
        }
    }
    
    // MARK: Action
    @objc func reSendButtonDidTap() {
        limitTime = 300
    }
    
    @objc func certiCompleteButtonDidTap() {
        let settingVC = PasswordSettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        [firstCNum, secondCNum, thirdCNum, fourthCNum].forEach {
            $0.frame.origin.y = bounds.height/3.02985074627
        }
        timerLabel.frame.origin.y = bounds.height/2.4457831325
        reSendButton.frame.origin.y = bounds.height/2.4457831325
        certifiCompleteButton.frame.origin.y = bounds.height/1.9333333333
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        [firstCNum, secondCNum, thirdCNum, fourthCNum].forEach {
            $0.frame.origin.y = bounds.height/2.01990049751
        }
        timerLabel.frame.origin.y = bounds.height/1.7424892704
        reSendButton.frame.origin.y = bounds.height/1.7424892704
        certifiCompleteButton.frame.origin.y = bounds.height/1.2971246006
    }
}
