import UIKit

extension UIButton {
    
    func setTitleColorForMode(darkModeColor: UIColor, lightModeColor: UIColor) {
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        let titleColor = darkModeColor.resolvedColor(with: traitCollection)
        setTitleColor(titleColor, for: .normal)
    }
    
    func setButtonBackgroundColor(lightModeColor: UIColor, darkModeColor: UIColor) {
        let backgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkModeColor : lightModeColor
        }
        self.backgroundColor = backgroundColor
    }
    
    func setButtonBorderColor(lightModeColor: UIColor, darkModeColor: UIColor) {
        let borderColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkModeColor : lightModeColor
        }
        self.layer.borderColor = borderColor.cgColor
    }
    
    convenience init(filterButton title: String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(.color.gomsSecondary.color, for: .normal)
        titleLabel?.font = UIFont.pretendard(size: 16, weight: .semibold)
        frame = CGRect(x: 0, y: 0, width: 101, height: 56)
        backgroundColor = .clear
        layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
}
