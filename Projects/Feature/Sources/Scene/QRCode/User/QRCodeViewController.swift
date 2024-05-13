import UIKit
import AVFoundation
import Vision

public class QRCodeViewController: BaseViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
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
    
    private let qrIcon = UIImageView().then {
        $0.image = .image.gomsqrIcon.image
    }
    
    // MARK: - Life Cycel
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    // MARK: - Add View
    public override func addView() {
        [gomsLogo, closeButton, qrIcon].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Layout
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
        
        qrIcon.snp.makeConstraints {
            $0.width.height.equalTo(232)
            $0.centerY.centerX.equalToSuperview()
        }
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

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(output)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

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
                    DispatchQueue.main.async {
                        isScanningEnabled = false
                        
                        var alert = UIAlertController(title: "QR코드 스캔 성공", message: "외출을 시작합니다.\n 7시 30분까지 복귀해 주세요.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Action", style: .default) { action in
                            let mainVC = MainViewController()
                            self.navigationController?.pushViewController(mainVC, animated: true)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        
                        self.captureSession.stopRunning()
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
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        let previewSize: CGFloat = 200
        
        let previewX = (screenWidth - previewSize) / 2
        let previewY = (screenHeight - previewSize) / 2
        
        previewLayer.frame = CGRect(x: previewX, y: previewY, width: previewSize, height: previewSize)
    }
    
    // MARK: Action
    @objc func closeButtonDidTap() {
        print("터치")
        let mainVC = MainViewController()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
}
