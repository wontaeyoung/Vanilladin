import UIKit

protocol AladinServiceInterface {
    func requestBooks(
        keyword: String,
        page: UInt
    ) async throws -> [BookDTO]
    
    func requestCoverImage(
        _ urlStr: String
    ) async throws -> UIImage
}
