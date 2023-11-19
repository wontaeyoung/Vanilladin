import UIKit

final class BookRepository: BookRepositoryInterface {
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
    ) async throws -> (totalItem: UInt, data: [Book]) {
        let bookResult: SearchBookResult = try await aladinService.requestBooks(
            keyword: keyword,
            page: page)
        
        let totalItem: UInt = UInt(bookResult.totalResults)
        
        let books: [Book] = try await AsyncManager().mapConcurrently(from: bookResult.item) { dto in
            guard let cacheImage: UIImage = ImageCacheManager.shared.getObject(for: dto.cover) else {
                let coverImage: UIImage = try await self.aladinService.requestCoverImage(dto.cover)
                ImageCacheManager.shared.setObject(coverImage, for: dto.cover)
                
                return dto.asModel(with: coverImage)
            }
            
            return dto.asModel(with: cacheImage)
        }
        
        return (totalItem, books)
    }
    
    func fetchBookDetail(isbn13: String) async throws -> BookDetail {
        let bookResult: LookupBookResult = try await aladinService.requestBookDetail(isbn13: isbn13)
        
        guard let bookDetail = bookResult.item.first else {
            return .dummy
        }
        
        return bookDetail.asModel(with: nil)
    }
}
