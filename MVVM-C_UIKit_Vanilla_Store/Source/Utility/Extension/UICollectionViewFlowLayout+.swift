import UIKit

extension UICollectionViewFlowLayout {
    func setAttribute(
        direction: UICollectionView.ScrollDirection,
        width: CGFloat,
        height: CGFloat,
        lineSpacing: CGFloat,
        itemSpacing: CGFloat,
        inset: UIEdgeInsets
    ) {
        self.scrollDirection = direction
        self.itemSize = .init(width: width, height: height)
        self.minimumLineSpacing = lineSpacing
        self.minimumInteritemSpacing = itemSpacing
        self.sectionInset = inset
    }
}
