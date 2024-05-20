import Foundation
import UIKit
import QRCode

public class AdminQRCodeViewController: BaseViewController {
    
    // MARK: Propertices
    let viewModel = QRCodeViewModel()
    
    private var timer: Int = 300
    
    private let titleText = UILabel().then {
        $0.text = "외출 QR코드"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = UIFont.pretendard(size: 29, weight: .bold)
    }
    
    private let qrCodeView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let lastTimeText = UILabel().then {
        $0.text = "QR코드 만료까지"
        $0.textColor = .color.gomsSecondary.color
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
    }
    
    private var lastTimer = UILabel().then {
        $0.text = "5분 00초"
        $0.textColor = .color.gomsAdmin.color
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    // MARK: Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        createQrCode()
    }
    
    // MARK: Add View
    override func addView() {
        [titleText, qrCodeView, lastTimeText, lastTimer].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: Set Layout
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
        }
        
        qrCodeView.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).offset(124)
            $0.centerX.equalToSuperview()
        }
        
        lastTimeText.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(qrCodeView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        lastTimer.snp.makeConstraints {
            $0.top.equalTo(lastTimeText.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            self.timer -= 1
            let minutes = self.timer / 60
            let seconds = self.timer % 60
            if self.timer > 0 {
                self.lastTimer.text = String(format: "%d분 %02d초", minutes, seconds)
            }
            else {
                self.lastTimer.text = "0분 00초"
                self.createQrCode()
                self.timer = 300
            }
        })
    }
    
    func createQrCode() {
        let urlUUID = self.viewModel.outingUUID
        let qrCodeURLString = "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2/outing/\(urlUUID)"
        
        var qrCode = QRCode(string: qrCodeURLString) // qr 생성 데이터
        qrCode?.color = .black  // qr 코드 선 색상
        qrCode?.backgroundColor = .white // qr 코드 배경 색상
        qrCode?.size = CGSize(width: 200, height: 200) // 사이즈 정의
        qrCode?.scale = 1.0 // scaling
        qrCode?.inputCorrection = .quartile
        
        guard (qrCode?.image) != nil else {
            return
        }
        
        let qrImageView = UIImageView.init(qrCode: qrCode! as QRCode)
        
        self.qrCodeView.addSubview(qrImageView)
        
        qrImageView.snp.makeConstraints {
            $0.height.width.equalTo(bounds.width * 0.53)
            $0.edges.equalToSuperview()
        }
    }
}
