final class MyBookRepository: MyBookRepositoryInterface {
    // MARK: - Property
    private let aladinService: AladinService
    private let coreDataService: CoreDataService
    
    // MARK: - Initializer
    init(
        aladinService: AladinService,
        coreDataService: CoreDataService
    ) {
        self.aladinService = aladinService
        self.coreDataService = coreDataService
    }
    
    // MARK: - Method
    func save(myBook: MyBook) throws {
        let myBookDTO: MyBookDTO = myBook.asDTO()
        
        try coreDataService.saveMyBook(myBookDTO: myBookDTO)
    }
    
    func fetch(isbn13: String) async throws -> MyBook {
        let myBookDTO: MyBookDTO = try coreDataService.fetchMyBook(isbn13: isbn13)
        
        guard let cacheImage = ImageCacheManager.shared.getObject(for: myBookDTO.cover) else {
            let coverImage: UIImage = try await aladinService.requestCoverImage(myBookDTO.cover)
            ImageCacheManager.shared.setObject(coverImage, for: myBookDTO.cover)
            
            return myBookDTO.asModel(with: coverImage)
        }
        
        return myBookDTO.asModel(with: cacheImage)
    }
    
    func fetch() throws -> [MyBookDTO] {
        return try coreDataService.fetchMyBooks()
    }
}
