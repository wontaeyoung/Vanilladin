import UIKit

protocol AladinServiceInterface {
    func requestBooks(
        query: String,
        page: Int
    ) async throws -> [BookDTO]
    
    func requestCoverImage(
        _ urlStr: String
    ) async throws -> UIImage
}
