import UIKit

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
        try coreDataService.saveMyBook(myBook: myBook)
    }
    
    func remove(myBook: MyBook) throws {
        try coreDataService.removeMyBook(myBook: myBook)
    }
    
    func fetch(isbn13: String) async throws -> MyBook {
        let myBookDTO: MyBookDTO = try coreDataService.fetchMyBook(isbn13: isbn13)
        let coverImage: UIImage = try await aladinService.requestCoverImage(myBookDTO.cover)
        
        return myBookDTO.asModel(with: coverImage)
    }
    
    func fetch() async throws -> [MyBook] {
        let myBookDTOs: [MyBookDTO] = try await coreDataService.fetchMyBooks()
        
        let myBooks: [MyBook] = try await AsyncManager().mapConcurrently(from: myBookDTOs) { [weak self] dto in
            guard let self else {
                print(#function, AppError.unwrapSelfFailed.errorDescription)
                throw AppError.unwrapSelfFailed
            }
            
            let coverImage: UIImage = try await aladinService.requestCoverImage(dto.cover)
            
            return dto.asModel(with: coverImage)
        }
        
        return myBooks
    }
    
    func isRegistered(isbn13: String) -> Bool {
        return coreDataService.isRegistered(isbn13: isbn13)
    }
}
