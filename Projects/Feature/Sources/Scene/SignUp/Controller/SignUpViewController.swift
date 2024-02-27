import UIKit

public class SignUpViewController: BaseViewController {
    let text = UILabel().then {
        $0.text = "회원가입 페이지"
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addView() {
        [text].forEach { view.addSubview($0) }
    }
    
    override func setLayout() {
        text.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
