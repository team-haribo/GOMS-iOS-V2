import UIKit

import AVFoundation

public class QRCodeViewController: BaseViewController {
    private let qrScanBackground = UIImageView().then {
        $0.image = .image.gomsqrBackground.image
    }
    
    private let gomsLogo = UIImageView().then {
        $0.image = .image.gomsWhiteLogo.image
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(.image.gomsClostButton.image, for: .normal)
        $0.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private let qrScanner = UIImageView().then {
        $0.image = .image.gomsqrScanner.image
    }
    
    private let qrScannerPhone = UIImageView().then {
        $0.image = .image.gomsqrScannerPhone.image
    }
    
    private let qrScannerBlur = UIImageView().then {
        $0.image = .image.gomsqrScannerBlur.image
    }
    
    private let qrIcon = UIImageView().then {
        $0.image = .image.gomsqrIcon.image
    }
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    public override func addView() {
        [qrScanBackground, gomsLogo, closeButton, qrScanner, qrScannerPhone, qrScannerBlur, qrIcon].forEach {
            view.addSubview($0)
        }
    }
    
    public override func setLayout() {
        qrScanBackground.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        gomsLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(64)
            $0.trailing.equalToSuperview().inset(20)
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
        
        qrIcon.snp.makeConstraints {
            $0.width.height.equalTo(136)
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    // MARK: Action
    @objc func closeButtonDidTap(_ sender: Any) {
        print("닫기")
    }

    public func setupCamera() {
        guard let camera = AVCaptureDevice.default(for: .video) else {
            print("카메라를 찾을 수 없습니다.")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(input)
        } catch {
            print("카메라 입력을 설정하는 중 오류 발생: \(error.localizedDescription)")
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        let previewSize: CGFloat = 120
        
        let previewX = (screenWidth - previewSize) / 2
        let previewY = (screenHeight - previewSize) / 2
        
        previewLayer.frame = CGRect(x: previewX, y: previewY, width: previewSize, height: previewSize)
    }
}
