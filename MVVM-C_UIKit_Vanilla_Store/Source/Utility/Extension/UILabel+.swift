import UIKit

extension UILabel {
    var isTruncated: Bool {
        guard 
            let labelText = text,
            labelText.isEmpty == false
        else {
            return false
        }
        
        let labelTextSize = (labelText as NSString)
            .boundingRect(
                with: CGSize(width: frame.width, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: font ?? UIFont()],
                context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}
