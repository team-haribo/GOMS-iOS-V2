import UIKit

import AVFoundation

public class ViewController: BaseViewController {

    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
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
