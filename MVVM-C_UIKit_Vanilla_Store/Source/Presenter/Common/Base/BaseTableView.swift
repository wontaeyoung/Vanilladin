import UIKit

class BaseTableView: UITableView {
    
    // MARK: - Method
    func registerCells() { }
    
    func register(_ cellClass: UITableViewCell.Type) {
        let identifier: String = .init(describing: cellClass)
        
        self.register(cellClass.self, forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell(
        _ cellClass: UITableViewCell.Type,
        for indexPath: IndexPath
    ) -> UITableViewCell? {
        let identifier: String = .init(describing: cellClass)
        let cell: UITableViewCell? = self.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
        
        return cell
    }
    
    // MARK: - Initializer
    init() {
        super.init(
            frame: .zero,
            style: .plain
        )
        
        self.registerCells()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in BaseTableView")
    }
}
