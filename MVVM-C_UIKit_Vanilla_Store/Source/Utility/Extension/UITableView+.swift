import UIKit

extension UITableView {
    func dequeueCell(
        _ cellClass: UITableViewCell.Type,
        for indexPath: IndexPath
    ) -> UITableViewCell {
        let identifier: String = .init(describing: cellClass)
        let cell: UITableViewCell = self.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
        
        return cell
    }
}
