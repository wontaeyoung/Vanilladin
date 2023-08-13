final class SearchBookViewModel: ViewModelProtocol {
    // MARK: - Property
    private weak var coordinator: BookCoordinator?
    private let bookRepository: BookRepository
    private let bookDataSource: BookDataSource
    
    var isResultEmpty: Bool {
        return bookDataSource.entities.isEmpty
    }
    
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
    
    // MARK: - Method
    func fetchBooks(keyword: String) async {
        do {
            let books: [Book] = try await bookRepository.fetchBooks(
                keyword: keyword,
                page: bookDataSource.currentLoadPage
            )
            
            bookDataSource.entities = books
        } catch {
            guard let error = error as? AppErrorProtocol else {
                print(#function, "에러 타입캐스팅 실패!")
                return
            }
            
            coordinator?.handle(error: error)
        }
    }
}
