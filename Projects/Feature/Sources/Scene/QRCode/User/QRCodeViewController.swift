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
                
                    let qrFrameRect = CGRect(x: self.qrFrame.frame.origin.x,
                                             y: self.qrFrame.frame.origin.y,
                                             width: self.qrFrame.frame.width * self.view.bounds.width,
                                             height: self.qrFrame.frame.height * self.view.bounds.height)
                    
                    if qrFrameRect.contains(CGPoint(x: qrCodeBoundingBox.midX * self.view.bounds.width,
                                                    y: qrCodeBoundingBox.midY * self.view.bounds.height)) {
                        DispatchQueue.main.async {
                            isScanningEnabled = false
                            
                            print("QR 인식 후 UUID : \(self.viewModel.outingUUID)") 
                            
                            self.viewModel.outing { success in
                                if success {
                                    let alert = UIAlertController(title: "외출 복귀", message: "외출 복귀 처리되었습니다.", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "확인", style: .default) { _ in
                                        let mainVC = MainViewController()
                                        self.navigationController?.pushViewController(mainVC, animated: true)
                                    }
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    let alert = UIAlertController(title: "오류", message: "외출 처리 중 오류가 발생하였습니다.", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                }
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
