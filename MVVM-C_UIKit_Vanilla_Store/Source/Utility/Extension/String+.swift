import UIKit

extension String {
    var attributedTitleText: NSMutableAttributedString {
        let separatedTitle: [String] = self.components(separatedBy: "-")
        let attributedTitle: NSMutableAttributedString = .init(
            string: separatedTitle.first ?? "title",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: UIConstant.FontSize.title)
            ]
        )
        let attributedSubTitle: NSAttributedString = .init(
            string: " - " + (separatedTitle.last ?? "subTitle"),
            attributes: [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: UIConstant.FontSize.description)
            ]
        )
        
        attributedTitle.append(attributedSubTitle)
        
        return attributedTitle
    }
}
