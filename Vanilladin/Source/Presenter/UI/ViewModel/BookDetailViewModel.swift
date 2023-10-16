final class BookDetailViewModel: ViewModelProtocol {
    // MARK: - Property
    private let bookRepository: BookRepository
    
    // MARK: - Initializer
    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }
    
    // MARK: - Method
    func requestBookDetail(isbn13: String) async throws -> BookDetail {
        return try await bookRepository.fetchBookDetail(isbn13: isbn13)
    }
}
