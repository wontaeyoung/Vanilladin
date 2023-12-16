final class MyBookRepository: MyBookRepositoryInterface {
    // MARK: - Property
    private let coreDataService: CoreDataService
    
    // MARK: - Initializer
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    // MARK: - Method
    func save(myBookDTO: MyBookDTO) throws {
        try coreDataService.saveMyBook(myBookDTO: myBookDTO)
    }
    
    func fetch(isbn13: String) throws -> MyBookDTO {
        return try coreDataService.fetchMyBook(isbn13: isbn13)
    }
    
    func fetch() throws -> [MyBookDTO] {
        return try coreDataService.fetchMyBooks()
    }
}
