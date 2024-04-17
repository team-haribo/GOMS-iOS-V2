import UIKit
import QRCode

extension UIImage {
    static let image = FeatureAsset.Images.self
}

extension UIImageView {
    convenience init(qrCode: QRCode) {
        self.init(image: qrCode.unsafeImage)
    }
}
