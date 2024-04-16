import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

class QRCodeView: UIView {
    // CIQRCodeGeneratator : QR Code 생성 필터를 식별하기 위한 속성
//    var filter = CIFilter(name: "CIQRCodeGenerator")

    // QRCode CIImage를 만들어서 추가할 UIImageView
    var imageView = UIImageView()
    
//    // 이미지 렌더링을 처리하는 부분
//    let context = CIContext()
//    // QR 코드 생성기 필터
//    let filter = CIFilter.qrCodeGenerator()
//    
//    let qrData = "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2/outing/\(urlUUID)"
//    filter.setValue(qrData.data(using: .utf8), forKey: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
//    func generateCode(_ string: String) {
//        //주어진 인코딩을 사용해서 NSData 개체 반환
//        guard let filter = filter, let data = string.data(using: .isoLatin1, allowLossyConversion: false) else {
//            return
//        }
//
//        // 두가지 파라미터 설정
//        filter.setValue(data, forKey: "inputMessage")
//        filter.setValue("M", forKey: "inputCorrectionLevel")
//
//        // .outputImage : 필터에 구성된 작업을 캡슐화하는 CIImage 개체이다. 즉, 결과물
//        guard let ciImage = filter.outputImage else {
//            return
//        }
//
//        // 이미지 선명
//        let transformed = ciImage.transformed(by: CGAffineTransform.init(scaleX: 10, y: 10))
//
//        // QR Code 색 커스텀
//        let invertFilter = CIFilter(name: "CIColorInvert")
//        invertFilter?.setValue(transformed, forKey: kCIInputImageKey)
//
//        let alphaFilter = CIFilter(name: "CIMaskToAlpha")
//        alphaFilter?.setValue(invertFilter?.outputImage, forKey: kCIInputImageKey)
//
//        if let outputImage = alphaFilter?.outputImage {
//            imageView.tintColor = .black
//            imageView.backgroundColor = .color.gomsBackground.color
//            imageView.image = UIImage(ciImage: outputImage, scale: 2.0, orientation: .up).withRenderingMode(.alwaysTemplate)
//        } else {
//            return
//        }
//    }
}
