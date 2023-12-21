final class BookDetailViewModel: ViewModelProtocol {
    // MARK: - Property
    private let dataSource: MyBookDataSource
    weak var coordinator: BookCoordinator?
    
    // MARK: - Initializer
    init(dataSource: MyBookDataSource) {
        self.dataSource = dataSource
    }
    
    // MARK: - Method
    func saveMyBook(book: Book) {
        do {
            try dataSource.saveMyBook(book: book)
        } catch {
            coordinator?.handle(error: error)
        }
    }
    
    func isRegister(isbn13: String) -> Bool {
        return dataSource.isRegistered(isbn13: isbn13)
    }
}
