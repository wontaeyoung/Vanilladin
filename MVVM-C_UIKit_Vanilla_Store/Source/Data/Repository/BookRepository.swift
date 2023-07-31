import UIKit

final class BookRepository: DependencyContainable {
    // MARK: - Stored Property
    private let aladinService: AladinService
    
    // MARK: - Initializer
    init(
        aladinService: AladinService = .init()
    ) {
        self.aladinService = aladinService
    }
    
    // MARK: - Method
    func fetchBook(
        keyword: String,
        page: UInt
    ) async throws -> [Book] {
        let booksDTO: [BookDTO] = try await aladinService.requestBooks(
            keyword: keyword,
            page: page
        )
        
        let books: [Book] = try await AsyncManager.shared.mapConcurrently(from: booksDTO) { dto in
            let coverImage: UIImage = try await self.aladinService.requestCoverImage(dto.cover)
            return dto.asModel(with: coverImage)
        }
        
        return books
    }
}
