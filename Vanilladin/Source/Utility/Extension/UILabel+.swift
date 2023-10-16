import UIKit

extension UILabel {
    var isTruncated: Bool {
        guard 
            let labelText = text,
            labelText.isEmpty == false
        else {
            return false
        }
        
        /// with:: 이 크기 내에서 텍스트의 크기를 계산합니다. 주로 너비를 제한하고 높이를 CGFloat.greatestFiniteMagnitude로 설정하여 최대 높이 제한 없이 텍스트가 얼마나 많은 공간을 차지할지 알아보기 위해 사용됩니다.
        /// options:: 여기에서는 .usesLineFragmentOrigin 옵션이 사용됩니다. 이 옵션을 사용하면 텍스트가 여러 줄에 걸쳐 그려질 때의 크기를 계산할 수 있습니다. 이 옵션 없이는 텍스트를 한 줄로 간주하고 계산합니다.
        /// attributes:: 텍스트를 그릴 때 사용할 속성을 지정합니다. 여기에서는 텍스트의 폰트만 지정되어 있습니다. 이 폰트는 UILabel의 폰트와 일치해야 합니다.
        /// context:: 추가 정보나 텍스트 레이아웃 설정을 제공할 수 있는 컨텍스트입니다. 현재는 사용되지 않습니다.
        let labelTextSize = (labelText as NSString)
            .boundingRect(
                with: CGSize(width: frame.width, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: font ?? UIFont()],
                context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}
