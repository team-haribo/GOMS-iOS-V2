import UIKit

extension UIButton {
    convenience init(filterButton title: String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(.color.gomsSecondary.color, for: .normal)
        titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        frame = CGRect(x: 0, y: 0, width: 101, height: 56)
        backgroundColor = .color.gomsLightBackground.color
        layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
}
