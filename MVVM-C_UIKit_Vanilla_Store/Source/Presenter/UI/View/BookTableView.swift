import UIKit

final class BookTableView: BaseTableView {

    // MARK: - Method
    override func registerCells() {
        register(BookCell.self)
    }
}
