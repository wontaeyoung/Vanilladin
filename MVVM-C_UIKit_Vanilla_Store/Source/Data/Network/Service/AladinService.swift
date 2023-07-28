import UIKit

final class AladinService: AladinServiceInterface {
    // MARK: - Stored Property
    private let httpClient: HTTPClientInterface
    
    // MARK: - Initializer
    init(
        httpClient: HTTPClientInterface = HTTPClient()
    ) {
        self.httpClient = httpClient
    }
    
    // MARK: - Method
    func requestBooks(
        keyword: String,
        page: UInt
    ) async throws -> [BookDTO] {
        let apiRequest: APIRequest = .init(
            scheme: .http,
            host: .aladin,
            endpoint: AladinAPIEndpoint.itemSearch(keyword: keyword, page: page)
        )
        
        let booksDTO: [BookDTO] = try await httpClient
            .sendDTORequest(
                apiRequest: apiRequest,
                decodeType: Result.self
            )
            .item
        
        return booksDTO
    }
    
    func requestCoverImage(
        _ urlStr: String
    ) async throws -> UIImage {
        guard let image = try await httpClient.sendImageRequest(urlStr: urlStr) else {
            return UIImage(systemName: "text.book.closed.fill") ?? .actions
        }
        
        return image
    }
}
