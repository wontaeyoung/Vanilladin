final class BookListViewModel: DependencyContainable {

    // MARK: - Stored Property
    private(set) var books: [Book]
    private weak var coordinator: BookCoordinator?
    
    // MARK: - Initializer
    init(
        books: [Book] = [],
        coordinator: BookCoordinator?
    ) {
        self.books = books
        self.coordinator = coordinator
    }
    
    // MARK: - Method
    
}
