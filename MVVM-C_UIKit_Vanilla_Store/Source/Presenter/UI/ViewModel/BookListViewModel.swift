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
}
