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
        if result == "comeback" {
            let vc = CombackScuccessVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if result == "outing" {
            let vc = OutingSuccessVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if result == "blackList" {
            let vc = BlackListVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if result == "uuidError" {
            let vc = QRErrorVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        
        DispatchQueue.global().async {
            self.captureSession.startRunning()
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
                    DispatchQueue.main.async {
                        let qrFrameRect = self.qrFrame.convert(self.qrFrame.bounds, to: self.view)
                        
                        let qrFrameTopLeft = qrFrameRect.origin
                        let qrFrameTopRight = CGPoint(x: qrFrameRect.maxX, y: qrFrameRect.minY)
                        let qrFrameBottomLeft = CGPoint(x: qrFrameRect.minX, y: qrFrameRect.maxY)
                        let qrFrameBottomRight = CGPoint(x: qrFrameRect.maxX, y: qrFrameRect.maxY)
                        
                        let boundingBox = barcode.boundingBox
                        let barcodeTopLeft = CGPoint(x: boundingBox.minX * self.view.bounds.width, y: boundingBox.minY * self.view.bounds.height)
                        let barcodeTopRight = CGPoint(x: boundingBox.maxX * self.view.bounds.width, y: boundingBox.minY * self.view.bounds.height)
                        let barcodeBottomLeft = CGPoint(x: boundingBox.minX * self.view.bounds.width, y: boundingBox.maxY * self.view.bounds.height)
                        let barcodeBottomRight = CGPoint(x: boundingBox.maxX * self.view.bounds.width, y: boundingBox.maxY * self.view.bounds.height)
                        
                        if qrFrameRect.contains(barcodeTopLeft)
                            && qrFrameRect.contains(barcodeTopRight)
                            && qrFrameRect.contains(barcodeBottomLeft)
                            && qrFrameRect.contains(barcodeBottomRight) {
                            
                            isScanningEnabled = false
                            
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
