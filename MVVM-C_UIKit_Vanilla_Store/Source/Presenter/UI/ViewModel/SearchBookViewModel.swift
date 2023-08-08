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
    
    // MARK: -Method
    func fetchBooks(
        keyword: String,
        page: UInt
    ) async throws {
        do {
            let books: [Book] = try await bookRepository.fetchBook(
                keyword: keyword,
                page: page
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
