import UIKit
import AVFoundation
import Vision

public class QRCodeViewController: BaseViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    let viewModel = QRCodeViewModel()
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let metadataObjectTypes: [AVMetadataObject.ObjectType] = [.qr]
    
    private let gomsLogo = UIImageView().then {
        $0.image = .image.gomsWhiteLogo.image
    }
    
    private lazy var closeButton = UIButton().then {
        $0.setImage(.image.gomsCloseButton.image, for: .normal)
        $0.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
    }
    
    private let qrFrame = UIImageView().then {
        $0.image = .image.qr.image
    }
    
    // MARK: - Life Cycel
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    // MARK: - Selector
    @objc func closeButtonDidTap() {
        let mainVC = MainViewController()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    // MARK: - Add View
    public override func addView() {
        [gomsLogo, closeButton, qrFrame].forEach { self.view.addSubview($0) }
    }
    
    // MARK: - Layout
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    public override func setLayout() {
        gomsLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(64)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        qrFrame.snp.makeConstraints {
            $0.width.height.equalTo(bounds.width * 0.64)
            $0.centerY.centerX.equalToSuperview()
        }
    }

    func qrScanResult(result: String) {
        var title = ""
        var message = ""
        
        if result == "comeback" {
            title = "QR코드 스캔 성공"
            message = "제 시간에 복귀에 성공했어요!\n다음 외출제에 또 만나요!"
        } else if result == "outing" {
            title = "QR코드 스캔 성공"
            message = "외출을 시작합니다.\n7시 30분까지 복귀해 주세요."
        } else if result == "blackList" {
            title = "QR코드 스캔 실패"
            message = "외출 금지 상태에서는\nQR 스캔을 할 수 없습니다."
        } else if result == "uuidError" {
            title = "QR코드 스캔 실패"
            message = "예기치 못한 오류가 발생했습니다.\n다시 시도해 주세요."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            let mainVC = MainViewController()
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    public func setupCamera() {
        guard let camera = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(input)
        } catch {
            print(error.localizedDescription)
            return
        }
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(output)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        [gomsLogo, closeButton, qrFrame].forEach { self.view.addSubview($0) }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        var isScanningEnabled = true
        guard isScanningEnabled else { return }
        
        let request = VNDetectBarcodesRequest { request, error in
            if let error = error {
                print("QR 코드 감지 중 오류 발생: \(error.localizedDescription)")
                return
            }
            
            guard let barcodes = request.results as? [VNBarcodeObservation] else { return }
            
            for barcode in barcodes {
                if let payload = barcode.payloadStringValue {
                    let qrCodeBoundingBox = barcode.boundingBox
                    
                    DispatchQueue.main.async {
                        let qrFrameRect = CGRect(x: self.qrFrame.frame.origin.x,
                                                 y: self.qrFrame.frame.origin.y,
                                                 width: self.qrFrame.frame.width * self.view.bounds.width,
                                                 height: self.qrFrame.frame.height * self.view.bounds.height
                        )
                        
                        if qrFrameRect.contains(CGPoint(x: qrCodeBoundingBox.midX * self.view.bounds.width,
                                                        y: qrCodeBoundingBox.midY * self.view.bounds.height)) {
                            
                            isScanningEnabled = false
                            
                            print("QR 인식 후 UUID : \(self.viewModel.outingUUID)")
                            self.viewModel.outingUUID = UUID(uuidString: payload) ?? UUID()
                            self.viewModel.outing { result in
                                self.qrScanResult(result: result)
                            }
                            self.captureSession.stopRunning()
                        }
                    }
                }
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("비디오 프레임 처리 중 오류 발생: \(error.localizedDescription)")
        }
    }
}
