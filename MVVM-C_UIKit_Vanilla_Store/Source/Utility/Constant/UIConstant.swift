import UIKit

enum UIConstant {
    enum DeviceSize {
        static let width: CGFloat = UIScreen.main.bounds.size.width
        static let height: CGFloat = UIScreen.main.bounds.size.height
    }
    
    enum FontSize {
        static let title: CGFloat = 14.0
        static let description: CGFloat = 12.0
    }
    
    enum SFSymbol {
        static let xMark: String = "xmark"
        static let textBookClosedFill: String = "text.book.closed.fill"
        static let listBullet: String = "list.bullet"
        static let tableCellsFill: String = "tablecells.fill"
        static let star: String = "star"
        static let starFill: String = "star.fill"
        static let starLeadinghalfFilled: String = "star.leadinghalf.filled"
        static let rectangleAndPencilAndEllipsis: String = "rectangle.and.pencil.and.ellipsis"
        static let textBubble: String = "text.bubble"
        static let wonsignSquare: String = "wonsign.square"
    }
    
    enum Rating {
        static let maxStarRatingCount: Int = 5
    }
}
