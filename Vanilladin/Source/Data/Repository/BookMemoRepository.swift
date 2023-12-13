final class BookMemoRepository: BookMemoRepositoryInterface {
    // MARK: - Property
    private let coreDataService: CoreDataService
    
    // MARK: - Initializer
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    // MARK: - Method
    func save(bookMemoDTO: MyBookDTO) throws {
        try coreDataService.saveBookMemo(bookMemoDTO: bookMemoDTO)
    }
    
    func fetch(isbn13: String) throws -> MyBookDTO {
        return try coreDataService.fetchBookMemo(isbn13: isbn13)
    }
    
    func fetch() throws -> [MyBookDTO] {
        return try coreDataService.fetchBookMemos()
    }
}
