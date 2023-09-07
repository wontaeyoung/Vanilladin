import UIKit

class BaseTableView: UITableView {
  
  // MARK: - Method
  func registerCells() { }
  func register(_ cellClass: UITableViewCell.Type) {
    let identifier: String = .init(describing: cellClass)
    
    self.register(cellClass.self, forCellReuseIdentifier: identifier)
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
    fatalError("init(coder:) BaseTableView")
  }
}
