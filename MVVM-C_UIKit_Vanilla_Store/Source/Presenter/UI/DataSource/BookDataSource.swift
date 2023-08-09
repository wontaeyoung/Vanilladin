import UIKit

final class BookDataSource: DataSourceProtocol {
    typealias Entity = Book
    
    // MARK: - Property
    private weak var delegate: DataSourceDelegateProtocol?
    
    var entities: [Entity] {
        didSet {
            delegate?.entitiesDidUpdate()
        }
    }
    
    // MARK: - Initializer
    init(
        entities: [Book] = []
    ) {
        self.entities = entities
    }
    
    // MARK: - Method
    func setDelegate(_ delegate: DataSourceDelegateProtocol) {
        self.delegate = delegate
    }
    
    func setTableViewDataSourceAsSelf(to tableView: BaseTableView) {
        tableView.dataSource = self
    }
}

extension BookDataSource: UITableViewDataSource {
    
}
