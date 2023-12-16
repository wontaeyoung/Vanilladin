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
        
        let books: [Book] = try await AsyncManager().mapConcurrently(from: bookResult.item) { [weak self] dto in
            guard let self else {
                print(#function, AppError.unwrapSelfFailed.errorDescription)
                throw AppError.unwrapSelfFailed
            }
            
            let coverImage: UIImage = try await aladinService.requestCoverImage(dto.cover)
            
            return dto.asModel(with: coverImage)
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
