import UIKit

final class BookRepository: DependencyContainable {
    // MARK: - Property
    private let aladinService: AladinService
    
    // MARK: - Initializer
    init(aladinService: AladinService) {
        self.aladinService = aladinService
    }
    
    // MARK: - Method
    func fetchBooks(
        keyword: String,
        page: UInt
    ) async throws -> [Book] {
        let booksDTO: [BookDTO] = try await aladinService.requestBooks(
            keyword: keyword,
            page: page)
        
        let books: [Book] = try await AsyncManager.shared.mapConcurrently(from: booksDTO) { dto in
            guard
                let cacheImage: UIImage = ImageCacheManager.shared.getObject(for: dto.cover)
            else {
                let coverImage: UIImage = try await self.aladinService.requestCoverImage(dto.cover)
                ImageCacheManager.shared.setObject(coverImage, for: dto.cover)
                
                return dto.asModel(with: coverImage)
            }
            
            return dto.asModel(with: cacheImage)
        }
        
        return books
    }
}
