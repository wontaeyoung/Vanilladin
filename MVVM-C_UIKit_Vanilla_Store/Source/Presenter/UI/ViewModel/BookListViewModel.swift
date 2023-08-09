final class BookListViewModel: ViewModelProtocol {

    // MARK: - Dependency
    private weak var coordinator: BookCoordinator?
    private let bookDataSource: BookDataSource
    
    // MARK: - UI
    private lazy var bookListTableView: UITableView
    
    // MARK: - Initializer
    init(
        coordinator: BookCoordinator? = nil,
        bookDataSource: BookDataSource
    ) {
        self.coordinator = coordinator
        self.bookDataSource = bookDataSource
    }
}
