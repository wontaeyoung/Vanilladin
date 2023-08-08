final class BookListViewModel: ViewModelProtocol {

    // MARK: - Stored Property
    private(set) var books: [Book]
    private weak var coordinator: BookCoordinator?
    
    // MARK: - Initializer
    init(
        books: [Book] = [],
        coordinator: BookCoordinator? = nil
    ) {
        self.books = books
        self.coordinator = coordinator
    }
}
