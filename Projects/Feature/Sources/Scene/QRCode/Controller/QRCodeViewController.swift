import UIKit
import AVFoundation

public class QRCodeViewController: BaseViewController {
    // MARK: Propertices
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let qrScanBackground = UIImageView().then {
        $0.image = .image.gomsqrBackground.image
    }
    
    private let gomsLogo = UIImageView().then {
        $0.image = .image.gomsWhiteLogo.image
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(.image.gomsCloseButton.image, for: .normal)
        $0.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
    }
    
//    private let qrScanner = UIImageView().then {
//        $0.image = .image.gomsqrScanner.image
//    }
//    
//    private let qrScannerPhone = UIImageView().then {
//        $0.image = .image.gomsqrScannerPhone.image
//    }
//    
//    private let qrScannerBlur = UIImageView().then {
//        $0.image = .image.gomsqrScannerBlur.image
//    }
    
    private let qrIcon = UIImageView().then {
        $0.image = .image.gomsqrIcon.image
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        basicSetting()
    }
    
    public override func addView() {
        [qrScanBackground, gomsLogo, closeButton, qrIcon].forEach {
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
        
        qrIcon.snp.makeConstraints {
            $0.width.height.equalTo(232)
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
        let previewSize: CGFloat = 200
        
        let previewX = (screenWidth - previewSize) / 2
        let previewY = (screenHeight - previewSize) / 2
        
        previewLayer.frame = CGRect(x: previewX, y: previewY, width: previewSize, height: previewSize)
    }
    
    private func setupQRScanner() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupCamera()
                    }
                }
            }
        default:
            showAlert()
        }
    }

    private func showAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(
                title: "Error",
                message: "카메라 접근을 허용해주세요",
                preferredStyle: .alert
            )
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

extension QRCodeViewController {
    private func basicSetting() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            fatalError("No video device found")
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            
            let output = AVCaptureMetadataOutput()
            
            captureSession.addOutput(output)
            
//            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            setVideoLayer()
//            setGuideCrossLineView()
            
            captureSession.startRunning()
        }
        catch {
            print("error")
        }
    }
    
    private func setVideoLayer() {
        let videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoLayer.frame = view.layer.bounds
        
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(videoLayer)
    }
    
//    private func setGuideCrossLineView() {
//        let guideCrossLine = UIImageView().then {
//            $0.image = UIImage(systemName: "plus")
//            $0.tintColor = .green
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//        
//        guideCrossLine.snp.makeConstraints {
//            $0.centerY.centerX.equalToSuperview()
//            $0.width.height.equalTo(30)
//        }
//    }
}

//extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
//    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        if metadataObjects.count == 0 {
//            return
//        }
//        
//        guard let metaDataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
//        
//        if metaDataObj.type == AVMetadataObject.ObjectType.qr {
//            if let outPutValue = metaDataObj.stringValue {
//                if outPutValue.hasPrefix("http://") || outPutValue.hasPrefix("https://")  {
//                    UrlLabel.setTitle(outPutValue, for: .normal)
//                    zoomIn()
//                    //print(url)
//                    captureSession.stopRunning()
//                }
//            }
//        }
//    }
//}
