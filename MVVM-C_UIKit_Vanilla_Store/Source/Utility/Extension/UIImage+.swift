import UIKit

extension UIImage {
    func colored(with color: UIColor) -> UIImage {
        return self.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
