final class BookListViewModel: ViewModelProtocol {

    // MARK: - Property
    private weak var coordinator: BookCoordinator?
    private let bookDataSource: BookDataSource
    
    // MARK: - Initializer
    init(
        coordinator: BookCoordinator? = nil,
        bookDataSource: BookDataSource
    ) {
        self.coordinator = coordinator
        self.bookDataSource = bookDataSource
    }
    
    // MARK: - Method
    func setDataSourceDelegate(_ delegate: DataSourceDelegateProtocol) {
        bookDataSource.setDelegate(delegate)
    }
    
    func setTableViewDataSource(to tableView: BaseTableView) {
        bookDataSource.setTableViewDataSourceAsSelf(to: tableView)
    }
    
    func increaseLoadPage() {
        bookDataSource.increaseLoadPage()
    }
}
