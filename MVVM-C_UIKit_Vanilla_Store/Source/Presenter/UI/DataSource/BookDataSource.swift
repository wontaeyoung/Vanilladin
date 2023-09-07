import UIKit

final class BookDataSource: NSObject, DataSourceProtocol {
  typealias Entity = Book
  
  // MARK: - Property
  private weak var delegate: DataSourceDelegate?
  
  var entities: [Entity] {
    didSet {
      delegate?.entitiesDidUpdate()
    }
  }
  
  private(set) var currentLoadPage: UInt
  
  // MARK: - Initializer
  init(
    entities: [Book] = []
  ) {
    self.entities = entities
    self.currentLoadPage = 1
  }
  
  // MARK: - Method
  func increaseLoadPage() {
    self.currentLoadPage += 1
  }
}

// MARK: - Set Dependency
extension BookDataSource {
  func setDelegate(_ delegate: DataSourceDelegate) {
    self.delegate = delegate
  }
  
  func setTableViewDataSourceAsSelf(to tableView: BaseTableView) {
    tableView.dataSource = self
  }
}

extension BookDataSource: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return entities.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let bookCell = tableView.dequeueCell(
      BookTableCell.self,
      for: indexPath
    ) as? BookTableCell else {
      return tableView.dequeueCell(UITableViewCell.self, for: indexPath)
    }
    
    guard let book = entity(at: indexPath.row) else {
      return bookCell
    }
    
    bookCell.book = book
    
    return bookCell
  }
}
