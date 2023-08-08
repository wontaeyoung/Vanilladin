final class SearchBookViewModel: ViewModelProtocol {
    // MARK: - Stored Property
    private weak var coordinator: BookCoordinator?
    private let bookRepository: BookRepository
    private let bookDataSource: BookDataSource
    
    // MARK: - Initializer
    init(
        coordinator: BookCoordinator? = nil,
        bookRepository: BookRepository,
        bookDataSource: BookDataSource
    ) {
        self.coordinator = coordinator
        self.bookRepository = bookRepository
        self.bookDataSource = bookDataSource
    }
}
