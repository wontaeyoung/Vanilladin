import UIKit

final class SearchKeywordHistoryTableView: BaseTableView {
    
    // MARK: - Method
    override func registerCells() {
        register(SearchKeywordCell.self)
    }
}
