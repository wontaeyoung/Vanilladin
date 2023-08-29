final class SearchHistoryViewModel: ViewModelProtocol {
    
    // MARK: - Property
    private let dataSource: SearchHistoryDataSource
    
    // MARK: - Initializer
    init(
        dataSource: SearchHistoryDataSource
    ) {
        self.dataSource = dataSource
    }
    
    // MARK: - Method
    func setTableViewDataSource(to tableView: BaseTableView) {
        dataSource.setTableViewDataSourceAsSelf(to: tableView)
    }
    
    func saveKeyword(_ keyword: String) {
        dataSource.saveKeyword(keyword: keyword)
    }
    
    func removeKeyword(_ index: Int) {
        dataSource.removeKeyword(at: index)
    }
    
    func removeAllKeywords() {
        dataSource.clearKeywords()
    }
    
    func getKeyword(at index: Int) -> String? {
        return dataSource.getKeyword(at: index)
    }
}
