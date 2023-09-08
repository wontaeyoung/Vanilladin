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
    }
}
