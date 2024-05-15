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
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setBackgroundImage(backgroundImage, for: state)
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
