import UIKit

extension UICollectionView {
    func dequeueCell(
        _ cellClass: UICollectionViewCell.Type,
        for indexPath: IndexPath
    ) -> UICollectionViewCell {
        let identifier: String = .init(describing: cellClass)
        
        let cell: UICollectionViewCell = self.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath)
        
        return cell
    }
}

