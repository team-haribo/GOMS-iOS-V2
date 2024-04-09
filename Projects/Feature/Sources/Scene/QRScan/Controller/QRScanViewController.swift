import UIKit

import QRCode

public class QRScanViewController: BaseViewController {
    // MARK: Propertices
    private let qrBackground = UIImageView().then {
        $0.image = .image.gomsQRBackground.image
    }
    
    private let qrScanner = UIImageView().then {
        $0.image = .image.gomsQRScanner.image
    }
    
    private let qrScannerPhone = UIImageView().then {
        $0.image = .image.gomsQRScannerPhone.image
    }
    
    private let qrScannerBlur = UIImageView().then {
        $0.image = .image.gomsQRScannerBlur.image
    }
    
    // MARK: Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: AddView
    override func addView() {
        [qrBackground, qrScanner, qrScannerPhone, qrScannerBlur].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: SetLayout
    override func setLayout() {
        qrBackground.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        qrScanner.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        qrScannerPhone.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        qrScannerBlur.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
}
