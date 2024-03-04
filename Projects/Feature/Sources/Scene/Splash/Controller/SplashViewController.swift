import UIKit
import SnapKit
import Then

public final class SplashViewController: BaseViewController {
    let iconImage = UIImageView().then {
        $0.image = .image.gomsGoms.image
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .color.gomsBackground.color
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToSignIn()
        }
    }
    
    // MARK: AddView
    override func addView() {
        [iconImage].forEach { view.addSubview($0) }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        iconImage.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func navigateToSignIn() {
        let signInVC = MainViewController()
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: false, completion: nil)
    }
}
